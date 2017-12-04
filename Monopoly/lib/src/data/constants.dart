class Constants {
  /// [tileListTableModal] provides a skeleton for a basic table with a static header
  static String tileListTableModal = '''
  <table class="table is-hoverable is-striped is-narrow is-fullwidth">
    <thead>
      <tr class="is-unselectable">
        <th>Color</th>
        <th>Name</th>
        <th>Amount</th>
        <th></th>
      </tr>
    </thead>
    <tbody class="modal-table-sel"></tbody>
  </table>
  ''';

  /// [auctionModal] provides a skeleton for a basic modal
  static String auctionModal = '''
  <p class='title current-bidder'></p>
  <div class="box">
    <article class="media">
      <div class="media-left">
        <a class="button is-large is-static tile-color-icon"><i class='icon'></i></a>
      </div>
      <div class="media-content">
        <div class="content">
          <p class="subtitle tile-name">

          </p>
        </div>
      </div>
      <div class="media-right">
        <p class="subtitle">
          Current Bid:
          <span class="has-text-info current-bid"></span>
          <br> Leader:
          <span class="has-text-info bid-leader"></span>
        </p>
      </div>
    </article>
  </div>
  <div class="form">
    <div class="field has-addons has-addons-centered">
      <p class="control">
        <a class="button is-static">
      Bid:
    </a>
      </p>
      <div class="control has-icons-left has-icons-right">
        <input class="input bid-input" type="number">
        <span class="icon is-small is-left">
          \$
        </span>
        <span class="icon is-small is-right">
          <i class=" validation-icon" aria-hidden="true"></i>
        </span>
      </div>
      <div class="control">
        <button class="button is-info submit-bid-button">
          <span class="icon is-small is-right">
            <i class="fa fa-arrow-right"></i>
          </span>

        </button>
      </div>
    </div>
    <div class="field has-addons has-addons-centered">
      <div class="control">
        <button class="button is-danger drop-out-button">
          <span class="icon">
            <i class="fa fa-flag-o" aria-hidden="true"></i>
          </span>
          <span>Drop Out</span>
        </button>
      </div>
    </div>
  </div>
  ''';

  static String classicBoardInfo =
      "Go,Go,None,0,0,0,0,0,0,0,0,0,0,Mediterranean Avenue,Street,#854c3a,1,60,50,2,10,30,90,160,250,2,Community Chest,Chest,None,2,0,0,0,0,0,0,0,0,0,Baltic Avenue,Street,#854c3a,3,60,50,4,20,60,180,320,450,2,Income Tax,Tax,None,4,200,0,200,0,0,0,0,0,0,Reading Railroad,Railroad,None,5,200,0,25,0,0,0,0,0,0,Oriental Avenue,Street,#aedcef,6,100,50,6,30,90,270,400,550,3,Chance,Chance,None,7,0,0,0,0,0,0,0,0,0,Vermont Avenue,Street,#aedcef,8,100,50,6,30,90,270,400,550,3,Connecticut Avenue,Street,#aedcef,9,120,50,8,40,100,300,450,600,3,Jail,Jail,None,10,0,0,0,0,0,0,0,0,0,St. Charles Place,Street,#c33c84,11,140,100,10,50,150,450,625,750,3,Electric Company,Utility,None,12,150,0,4,0,0,0,0,0,0,States Avenue,Street,#c33c84,13,140,100,10,50,150,450,625,750,3,Virginia Avenue,Street,#c33c84,14,160,100,12,60,180,500,700,900,3,Pennsylvania Railroad,Railroad,None,15,200,0,25,0,0,0,0,0,0,St. James Place,Street,#ea8b39,16,180,100,14,70,200,550,750,950,3,Community Chest,Chest,None,17,0,0,0,0,0,0,0,0,0,Tennessee Avenue,Street,#ea8b39,18,180,100,14,70,200,550,750,950,3,New York Avenue,Street,#ea8b39,19,200,100,16,80,220,600,800,1000,3,Free Parking,Parking,None,20,0,0,0,0,0,0,0,0,0,Kentucky Avenue,Street,#de252d,21,220,150,18,90,250,700,875,1050,3,Chance,Chance,None,22,0,0,0,0,0,0,0,0,0,Indiana Avenue,Street,#de252d,23,220,150,18,90,250,700,875,1050,3,Illinois Avenue,Street,#de252d,24,240,150,20,100,300,750,925,1100,3,B. & O. Railroad,Railroad,None,25,200,0,25,0,0,0,0,0,0,Atlantic Avenue,Street,#feee36,26,260,150,22,110,330,800,975,1150,3,Ventnor Avenue,Street,#feee36,27,260,150,22,110,330,800,975,1150,3,Water Works,Utility,None,28,150,0,4,0,0,0,0,0,0,Marvin Gardens,Street,#feee36,29,280,150,24,120,360,850,1025,1200,3,Go To Jail,GoToJail,None,30,0,0,0,0,0,0,0,0,0,Pacific Avenue,Street,#21a75a,31,300,200,26,130,390,900,1100,1275,3,North Carolina Avenue,Street,#21a75a,32,300,200,26,130,390,900,1100,1275,3,Community Chest,Chest,None,33,0,0,0,0,0,0,0,0,0,Pennsylvania Avenue,Street,#21a75a,34,320,200,28,150,450,1000,1200,1400,3,Short Line,Railroad,None,35,200,0,25,0,0,0,0,0,0,Chance,Chance,None,36,0,0,0,0,0,0,0,0,0,Park Place,Street,#0d67a2,37,350,200,35,175,500,1100,1300,1500,2,Luxury Tax,Tax,None,38,100,0,75,0,0,0,0,0,0,Boardwalk,Street,#0d67a2,39,400,200,50,200,600,1400,1700,2000,2";

  static String bozemanBoardInfo = """
Go,Go,None,0,0,0,0,0,0,0,0,0,0,
Beall Avenue,Street,LightBlue,1,60,50,2,10,30,90,160,250,2,
Community Chest,Chest,None,2,0,0,0,0,0,0,0,0,0,
Villard Street,Street,LightBlue,3,60,50,4,20,60,180,320,450,2,
Income Tax,Tax,None,4,200,0,200,0,0,0,0,0,0,
Montana Hall,Railroad,None,5,200,0,25,0,0,0,0,0,0,
Peach Street,Street,#EEE8AA,6,100,50,6,30,90,270,400,550,3,
Chance,Chance,None,7,0,0,0,0,0,0,0,0,0,
Tracy Avenue,Street,#EEE8AA,8,100,50,6,30,90,270,400,550,3,
Short Street,Street,#EEE8AA,9,120,50,8,40,100,300,450,600,3,
Jail,Jail,None,10,0,0,0,0,0,0,0,0,0,
Olive Street,Street,Green,11,140,100,10,50,150,450,625,750,3,
Northwestern Energy,Utility,None,12,150,0,4,0,0,0,0,0,0,
Story Street,Street,Green,13,140,100,10,50,150,450,625,750,3,
Koch Street,Street,Green,14,160,100,12,60,180,500,700,900,3,
Renne Library,Railroad,None,15,200,0,25,0,0,0,0,0,0,
College Street,Street,Orange,16,180,100,14,70,200,550,750,950,3,
Community Chest,Chest,None,17,0,0,0,0,0,0,0,0,0,
Harrison Street,Street,Orange,18,180,100,14,70,200,550,750,950,3,
Grant Street,Street,Orange,19,200,100,16,80,220,600,800,1000,3,
Free Parking,Parking,None,20,0,0,0,0,0,0,0,0,0,
Lincoln Street,Street,#B2B4B5,21,220,150,18,90,250,700,875,1050,3,
Chance,Chance,None,22,0,0,0,0,0,0,0,0,0,
Garfield Street,Street,#B2B4B5,23,220,150,18,90,250,700,875,1050,3,
Kagy Avenue,Street,#B2B4B5,24,240,150,20,100,300,750,925,1100,3,
Hamilton Hall,Railroad,None,25,200,0,25,0,0,0,0,0,0,
Durston Rd,Street,#A0522D,26,260,150,22,110,330,800,975,1150,3,
Oak Street,Street,#A0522D,27,260,150,22,110,330,800,975,1150,3,
Charter Communications,Utility,None,28,150,0,4,0,0,0,0,0,0,
Tschache Lane,Street,#A0522D,29,280,150,24,120,360,850,1025,1200,3,
Go To Jail,GoToJail,None,30,0,0,0,0,0,0,0,0,0,
7th Avenue,Street,LightGreen,31,300,200,26,130,390,900,1100,1275,3,
19th Avenue,Street,LightGreen,32,300,200,26,130,390,900,1100,1275,3,
Community Chest,Chest,None,33,0,0,0,0,0,0,0,0,0,
Rouse Avenue,Street,LightGreen,34,320,200,28,150,450,1000,1200,1400,3,
Romney Gym,Railroad,None,35,200,0,25,0,0,0,0,0,0,
Chance,Chance,None,36,0,0,0,0,0,0,0,0,0,
Main Street,Street,#DEB887,37,350,200,35,175,500,1100,1300,1500,2,
Luxury Tax,Tax,None,38,100,0,75,0,0,0,0,0,0,
Babcock Street,Street,#DEB887,39,400,200,50,200,600,1400,1700,2000,2
  """;
}
