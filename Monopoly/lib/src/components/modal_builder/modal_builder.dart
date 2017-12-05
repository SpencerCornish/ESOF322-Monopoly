import 'dart:html';

import '../tiles/tile.dart';
import '../app/app.dart';
import '../renderer/renderer.dart';
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
  App _app;
  Renderer _renderer;
  Element _currentBidderLabel;
  Element _tileColorIcon;
  Element _tileNameLabel;
  Element _currentBidLabel;
  Element _highestBidderLabel;
  Element _validationIcon;
  NumberInputElement _bidInputElement;
  ButtonElement _submitBidButton;
  ButtonElement _dropOutButton;

  ModalBuilder.listModal(this._title, List<Tile> selectionList,
      Function onClickFunction, this._app, this._renderer,
      {bool showNumBuildings = false, bool mortgage = false}) {
    _modalBody.appendHtml(Constants.tileListTableModal,
        validator: _basicValidator);

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
      Element button = querySelector('.tile-action-${tile.hashCode}');
      button.onClick.listen(onClickFunction);
    }
    // Closing handlers
    _closeButton.onClick.listen(_closeModal);
    _modalBackground.onClick.listen(_closeModal);
  }

  /// Builds a modal for auctioning, and handles all auction logic
  ModalBuilder.auctionModal(this._title, this._tile, List<Player> playerList,
      Player activePlayer, this._app, this._renderer) {
    // Deep clone the list
    _playerList = playerList.sublist(0);
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
    _validationIcon = querySelector('.validation-icon');
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
    _bidInputElement.onInput.listen(_validateBidInput);
    // Validates synthetic change events
    _bidInputElement.onChange.listen(_validateBidInput);

    // Button Handlers
    _submitBidButton.onClick.listen(_submitBid);
    _dropOutButton.onClick.listen(_dropOut);
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
    if (_bidInputElement.valueAsNumber <= _bidAmount ||
        _bidInputElement.valueAsNumber >= _currentBidder.money) {
      _bidInputElement.classes.remove('is-success');
      _bidInputElement.classes.add('is-danger');
      _validationIcon.className =
          "fa fa-exclamation-triangle has-text-danger validation-icon";
      _submitBidButton.disabled = true;
    } else {
      _bidInputElement.classes.remove('is-danger');
      _bidInputElement.classes.add('is-success');
      _validationIcon.className =
          "fa fa-check has-text-success validation-icon";
      _submitBidButton.disabled = false;
    }
  }

  _submitBid(_) {
    _bidAmount = _bidInputElement.valueAsNumber;
    _bidInputElement.valueAsNumber = _bidAmount + 10;
    _highestBidder = _currentBidder;
    _nextBidder();
  }

  _dropOut(_) {
    Player droppedPlayer = _currentBidder;
    _nextBidder();
    _playerList.remove(droppedPlayer);
    if (_playerList.length == 1) {
      _handleWinner();
    }
  }

  _nextBidder() {
    if (_playerList.length == 0) return;
    int nextIndex = _playerList.indexOf(_currentBidder) + 1;
    if (nextIndex > _playerList.length - 1) {
      _currentBidder = _playerList.first;
    } else {
      _currentBidder = _playerList[nextIndex];
    }

    if (_currentBidder.isComputer) {
      if (_currentBidder.money > _bidAmount + 10) {
        _submitBidButton.click();
        print("bid");
      } else {
        _dropOutButton.click();
        print("drop out");
      }
    }

    _updateAuctionData();
  }

  _handleWinner() async {
    _submitBidButton.disabled = true;
    _dropOutButton.text = 'Close';
    _bidInputElement.disabled = true;

    await window.animationFrame;
    _currentBidderLabel.text = "The winner is: ${_highestBidder.name}";

    // Display the highest bidder's name, or "None" if there isn't one
    _highestBidderLabel.text = _highestBidder?.name ?? "None";

    _highestBidder.buyTile(_tile, _bidAmount);

    // Closing handlers
    _dropOutButton.onClick.listen(_closeModal);
    _modalBackground.onClick.listen(_closeModal);
  }

  /// This is required in addition to [closeModal] above to support MouseEvent callbacks
  _closeModal(MouseEvent e) {
    _modal.className = "modal";
    _modalBody.children.clear();
    _app.updateButtons();
    _renderer.drawBackground();
  }

  // HTML Validator required for Modal construction
  NodeValidatorBuilder get _basicValidator {
    NodeValidatorBuilder validator = new NodeValidatorBuilder.common()
      ..allowInlineStyles();
    validator.allowInlineStyles();
    return validator;
  }
}
