<#

Script randomises room styles

#>

#We use ranges to create the elements in the array. I discovered these via trial and error.
#Old values with ALL tiles...
#$exteriorWall = @(69..79)
#$internalWall = @(124..233)
#$floor = @(72..118) #$floor = @(84,86,87,88,89,91,92,93,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127) # Broken/Bad Floors: 85, 90, 94
$directory = "G:\ProjectZomboidModding\ModTools\Building_TBX\RandoBuildings"

$exteriorWall = @(74,75,76,78,80,81,82,83,84,85,86,87,88,89,90,91,92,93) #Curated for just good outside walls
$internalWall = @(211,212,213,214,215,216,217,218,219,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246) #This is just coloured walls Bad Walls/Broken: #220,#221,
$internalTrim = @(56..69)
$floor = @(101,102,103,104,105,106,107,108,109,110,111,112,113)
$windows = @(319..324)
$curtains = @(1..32)
$shutters = @(278..281)
$doors = @(40..59) #37 starts, but shit doors...
$doorFrames = @(33..37)
$roofSlopes = @(280,281,282,283,284,286,287,288,289)
#Blue, Red, RedWood, Green, Pink,
$roofTops = @(290,291,293,294,295,296,297,298,299,300,301,302)
#Barn, BargsNCloth, Blue Brick,Red Brick,Wood,BrownSlats,WhiteSlats,BrownBrick,BrownBrick,DarkBrown,DarkBrown,BlueSlats,YellowSlats,GreyBrick,Wood,WhiteRectangleBrick
$roofCaps = @(264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279)

$blueRoofTops = @(290,291)
$redRoofTops = @(294,295)
$redWoodTops = @(292,293)
$tanRoofTops = @(298,299)
$greenRoofTops = @(300, 301)
$pinkRoofTops = @(302, 303)
$whiteRoofTops = @(304,305)

$blueRoofSlopes = @(280)
$redRoofSlopes = @(284)
$redWoodSlopes = @(282)
$tanRoofSlopes = @(286)
$greenRoofSlopes = @(288)
$whiteRoofSlopes = @(289)

$curatedRoofCaps = @(267,269,270,272,274,275,276,277,279) #275 = Blue Slat 276 = Yellow Slat


$stairs = @(310..318)

#START

$files = Get-ChildItem -Path $directory | Where { $_.Name -like "*.tbx" }

$intWallPat = 'InteriorWall="\d{1,3}"'
$floorPat = 'Floor="\d{1,3}"'
$grimeFloorPat = 'GrimeFloor="\d{1,3}"'
$doorFramePat = 'FrameTile="\d{1,3}"'
$curtainPat = 'CurtainsTile="\d{1,3}"'
$shutterPat = 'ShuttersTile="\d{1,3}"'
$exteriorPat = 'ExteriorWall="\d{1,3}"'
$roofPat = 'CapTiles="\d{1,3}" SlopeTiles="\d{1,3}" TopTiles="\d{1,3}"' `
#<object type="stairs" x="14" y="4" dir="N" Tile="310"/>
$stairPat = ' <object type="stairs" x="\d{1,3}" y="\d{1,3}" dir="[N|W]" Tile="\d{1,3}"/>' #Dir?? Need to create a loop over ze file to find dis?
#<object type="window" CurtainsTile="0" ShuttersTile="0" x="16" y="6" dir="W" Tile="319"/>
$windowPat = ' <object type="window" CurtainsTile="\d{1,3}" ShuttersTile="\d{1,3}" x="\d{1,3}" y="\d{1,3}" dir="[WN]" Tile="\d{1,3}"/>'
$doorPat = '  <object type="door" FrameTile="\d{1,3}" x="\d{1,3}" y="\d{1,3}" dir="[WN]" Tile="\d{1,3}"/>'

<#
#TODO: Specific patterns for each one...
$roofCapPat =
$roofSlopePat =
$roofTopPat =  
#>
$baseName = $files.BaseName
$combined = "$directory\" + "$baseName"


for($i = 0; $i -lt 10){
    $newPath = $combined+"$i.tbx"
    $window = Get-Random -InputObject $windows
    $door = Get-Random -InputObject $doors
    $doorFrame = Get-Random -InputObject $doorFrames
    $curtain = Get-Random -InputObject $curtains
    $shutter = Get-Random -InputObject $shutters
    $stair = Get-Random -InputObject $stairs #TODO: Use theses

    $roofCombination = Get-Random 6 #0 - 5
    $roofCapsSelected = Get-Random -InputObject $curatedRoofCaps
    $exteriorWallSelected = Get-Random -InputObject $exteriorWall
  

    #TODO: Determin roof here
    switch ($roofCombination) {
        0 { $roofSlopeSelected = Get-Random -InputObject $blueRoofSlopes; $roofTopSelected = Get-Random -InputObject $blueRoofTops; }
        1 { $roofSlopeSelected = Get-Random -InputObject $redRoofSlopes; $roofTopSelected = Get-Random -InputObject $redRoofTops; }
        2 { $roofSlopeSelected = Get-Random -InputObject $redWoodSlopes; $roofTopSelected = Get-Random -InputObject $RedWoodTops; }
        3 { $roofSlopeSelected = Get-Random -InputObject $tanRoofSlopes; $roofTopSelected = Get-Random -InputObject $tanRoofTops; }
        4 { $roofSlopeSelected = Get-Random -InputObject $greenRoofSlopes; $roofTopSelected = Get-Random -InputObject $greenRoofTops; }
        5 { $roofSlopeSelected = Get-Random -InputObject $whiteRoofSlopes; $roofTopSelected = Get-Random -InputObject $whiteRoofTops; }
    }



    Write-Host "Roof Roll: $roofCombination Windows: $window door: $door doorframe: $doorFrame Curtain: $curtain Shutter: $shutter Stair: $stair RoofSlope: $roofSlopeSelected RoofTop: $roofTopSelected File: $newPath"

    (Get-Content $files[0].FullName) | Foreach-Object {
    if($_ -match $stairPat){
        $_ -replace 'Tile="\d{1,3}"', "Tile=`"$stair`""
    }
    if($_ -match $windowPat){
        $_ -replace 'Tile="\d{1,3}"', "Tile=`"$window`""
    }
    if($_ -match $doorPat){
        $_ -replace 'Tile="\d{1,3}"', "Tile=`"$door`"" -replace 'FrameTile="\d{1,3}"', "FrameTile=`"$doorFrame`""
        #$_ -replace 'FrameTile="\d{1,3}"', "FrameTile=`"$doorFrame`""
    }
    <#
    if($_ -match $exteriorPat){
        $_ -replace "$exteriorPat", "ExteriorWall=`"$exteriorWallSelected`"" -replace 'RoofCap="\d{1,3}" RoofSlope="\d{1,3}" RoofTop="\d{1,3}"', "RoofCap=`"$roofCapSelected`" RoofSlope=`"$roofSlopeSelected`" RoofTop=`"$roofTopSelected`""
    }
    #>
    $_ -replace "$intWallPat", "InteriorWall=`"$(Get-Random -InputObject $internalWall)`"" `
       -replace "$floorPat", "Floor=`"$(Get-Random -InputObject $floor)`"" `
       -replace "$grimeFloorPat", "GrimeFloor=`"119`"" `
       -replace "$curtainPat", "CurtainsTile=`"$curtain`""`
       -replace "$shutterPat", "ShuttersTile=`"$shutter`""`
       -replace "$exteriorPat", "ExteriorWall=`"$(Get-Random -InputObject $exteriorWall)`"" `
       -replace "$roofPat", "CapTiles=`"$roofCapsSelected`" SlopeTiles=`"$roofTopSelected`" TopTiles=`"$roofSlopeSelected`"" `
       -replace "$doorPat", "" `
       -replace "$windowPat", "" `
       -replace "$stairPat", "" #Dirty, because we remove the next line but add our modified line... not great, needs beter fix.
    } | Set-Content $newPath


    $i++
}