TictactoeApp = angular.module("TictactoeApp", [])

# Controller
TictactoeApp.controller("TictactoeAppCtrl", ["$scope",
  ($scope)->
    status_idicators = $("#teams li")
    $scope.tiles = []
    $scope.players = [
      {
        name: "Ernie"
        marker: "X"
        img_url: "img/ernie.jpg"
        indicator: $(status_idicators[0])
        combo: []
      }
      ,
      {
        name: "Bert"
        marker: "O"
        img_url: "img/bert.jpg"
        indicator: $(status_idicators[1])
        combo: []
      }
    ]
    $scope.current_player = $scope.players[0]
    $scope.turns = 0
    $scope.win_combos = [
      [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
    ]

    # Create tiles 0-8 and push into tiles array to display board
    i = 0
    while i < 9
      newTile = {
        tilevalue: ""
        tileNum: i
        active: false
        tileWin: false
      }
      $scope.tiles.push(newTile)
      $scope.start = true      
      i += 1


    $scope.handle_click = (tile)->
      if tile.active is false
        # Set the value of that tile equal to the current player's marker,
        # Set tile.active to true,
        # And push the tile's tileNumb into the current player's combo array
        tile.tilevalue = $scope.current_player.marker
        tile.active = true
        $scope.current_player.combo.push(tile.tileNum)

        # Alternate turns if game is not yet won
        $scope.turns += 1
        if $scope.is_win($scope.current_player) isnt true and $scope.is_tie($scope.current_player) isnt true 
          if $scope.turns % 2 is 0
            $scope.current_player = $scope.players[0]      
          else
            $scope.current_player = $scope.players[1]

    # Function to determine if the current player's combo is a winning combo
    $scope.is_win = (current_player)->
      i = 0
      while i < $scope.win_combos.length
        check_combo = current_player.combo.intersect($scope.win_combos[i])
        i += 1
        if check_combo.length is 3
          console.log(check_combo)
          check_combo.forEach (index)->
            $scope.tiles[index].tileWin = true
          return true
      return

    # Function to determine if the current player's combo results in a tie
    $scope.is_tie = (current_player)->
      i = 0
      while i < $scope.win_combos.length
        check_combo = current_player.combo.intersect($scope.win_combos[i])
        i += 1
        if check_combo.length isnt 3 and current_player.combo.length is 5
          return true
      return

    $scope.hide_indicators = ()->

      return

    return
  ])
