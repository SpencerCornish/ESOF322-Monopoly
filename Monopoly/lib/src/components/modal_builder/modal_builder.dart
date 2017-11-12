import 'dart:html';

import '../tiles/tile.dart';
import '../player/player.dart';
import '../../data/constants.dart';

class ModalBuilder {
  // Core modal elements
  Element _modal = querySelector('.modal');
  Element _modalBackground = querySelector('.modal-background');
  Element _closeButton = querySelector('.delete');
  Element _modalBody = querySelector('.modal-card-body');
  Element _modalTitle = querySelector('.modal-card-title');

  String _title;

  // Auction variables
  Tile _tile;
  List<Player> _playerList;
  int _bidAmount = 0;
  Player _highestBidder;
  Player _currentBidder;

  // Auction Elements
  Element _currentBidderLabel;
  Element _tileColorIcon;
  Element _tileNameLabel;
  Element _currentBidLabel;
  Element _highestBidderLabel;
  NumberInputElement _bidInputElement;
  ButtonElement _submitBidButton;
  ButtonElement _dropOutButton;

  ModalBuilder.listModal(this._title, List<Tile> selectionList, Function onClickFunction,
      {bool showNumBuildings = false, bool mortgage = false}) {
    _modalBody.appendHtml(Constants.tileListTableModal, validator: _basicValidator);

    // User defined modal elements
    Element modalTable = querySelector('.modal-table-sel');

    // Set the Title String
    _modalTitle.text = _title;

    // Set the modal to visible, which populates the DOM with all child elements
    _modal.className = "modal is-active";

    // For every tile in our list, construct a row in the table, and push it to the DOM
    for (Tile tile in selectionList) {
      modalTable.insertAdjacentHtml(
          "beforeend",
          """
          <tr>
            <th><a class="button is-static is-small" style="background-color:${tile.color}"><span class="icon is-small">
            <td class="is-unselectable">${tile.name}</td>
            <td><p class="has-text-${mortgage && !tile.isMortgaged ? 'success' : 'danger'} is-unselectable">\$${(mortgage ? (tile.isMortgaged ? (tile.mortgageCost * 1.10) : tile.mortgageCost) : tile.buildPrice).toStringAsFixed(2)}</p></td>
            ${showNumBuildings ? '<td><p class="is-unselectable">${tile.numBuildings} Building${tile.numBuildings == 1 ? '' : 's'}</p></td>' : '' }
            ${mortgage ? '<td><p class="is-unselectable">${tile.isMortgaged ? 'Mortgaged' : ''}</p></td>' : '' }
            <td><a class="button is-small is-info is-outlined tile-action-${tile.hashCode}">Select</a></td>
          </tr>
          """,
          validator: _basicValidator);

      // Add a listener to the button
      LinkElement button = querySelector('.tile-action-${tile.hashCode}');
      button.onClick.listen(onClickFunction);
    }
    // Closing handlers
    _closeButton.onClick.listen(_closeModal);
    _modalBackground.onClick.listen(_closeModal);
  }

  /// Builds a modal for auctioning, and handles all auction logic
  ModalBuilder.auctionModal(this._title, this._tile, this._playerList, Player activePlayer) {
    // Set the current bidder to the current player
    _currentBidder = activePlayer;

    // Insert the DOM elements for the auction modal
    _modalBody.appendHtml(Constants.auctionModal, validator: _basicValidator);

    // Store References to each changing element
    _currentBidderLabel = querySelector('.current-bidder');
    _tileColorIcon = querySelector('.tile-color-icon');
    _tileNameLabel = querySelector('.tile-name');
    _currentBidLabel = querySelector('.current-bid');
    _highestBidderLabel = querySelector('.bid-leader');
    _bidInputElement = querySelector('.bid-input');
    _submitBidButton = querySelector('.submit-bid-button');
    _dropOutButton = querySelector('.drop-out-button');

    // Disable the bid button, to prep for data validation
    _submitBidButton.disabled = true;

    // Set the Title String
    _modalTitle.text = _title;

    _tileColorIcon.attributes = {'Style': 'background-color : ${_tile.color};'};
    _tileNameLabel.text = _tile.name;

    _updateAuctionData();

    _modal.className = 'modal is-active';

    // Validation Handlers
    _bidInputElement.onChange.listen(_validateBidInput);

    // Button Handlers
    _submitBidButton.onClick.listen(_submitBid);
    _dropOutButton.onClick.listen(_dropOut);

    // Closing handlers
    _closeButton.onClick.listen(_closeModal);
    _modalBackground.onClick.listen(_closeModal);
  }

  ////////////////
  /// External API
  ////////////////

  /// [closeModal] closes the modal instance
  closeModal() {
    _closeModal(null);
  }

  ///////////////////
  // Internal Helpers
  ///////////////////

  _updateAuctionData() async {
    // Update the current bidder and current bid amount
    _currentBidderLabel.text = 'Current Bidder: ${_currentBidder.name}';
    _currentBidLabel.text = '\$${_bidAmount}';

    // Display the highest bidder's name, or "None" if there isn't one
    _highestBidderLabel.text = _highestBidder?.name ?? "None";
  }

  _validateBidInput(_) {
    if (_bidInputElement.valueAsNumber <= _bidAmount) {}
  }

  _submitBid(_) {
    _bidAmount = (_bidInputElement.value as int);
    _highestBidder = _currentBidder;
    _nextBidder();
  }

  _dropOut(_) {
    _playerList.remove(_currentBidder);
    if (_playerList.length == 1) {
      // Handle a winning bid here
    }
    _nextBidder();
  }

  _nextBidder() {
    int nextIndex = _playerList.indexOf(_currentBidder) + 1;
    if (nextIndex > _playerList.length - 1) {
      _currentBidder = _playerList.first;
    } else {
      _currentBidder = _playerList[nextIndex];
    }
    _updateAuctionData();
  }

  /// This is required in addition to [closeModal] above to support MouseEvent callbacks
  _closeModal(MouseEvent e) {
    _modal.className = "modal";
    _modalBody.children.clear();
  }

  // HTML Validator required for Modal construction
  NodeValidatorBuilder get _basicValidator {
    NodeValidatorBuilder validator = new NodeValidatorBuilder.common()..allowInlineStyles();
    validator.allowInlineStyles();
    return validator;
  }
}
