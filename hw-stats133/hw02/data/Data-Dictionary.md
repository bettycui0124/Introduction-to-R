Data-dictionary.md
================
Betty Cui
3/4/2018

Data Dictionary of NBA2017 Player Statistics
--------------------------------------------

### Data Dictionary:

<table>
<colgroup>
<col width="17%" />
<col width="66%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="right"><strong>Vector</strong></th>
<th align="center"><strong>Meaning</strong></th>
<th align="left"><strong>Unit</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">period</td>
<td align="center">an NBA game is divided in 4 periods of 12 mins each</td>
<td align="left">minutes</td>
</tr>
<tr class="even">
<td align="right">minutes_remaining</td>
<td align="center">the amount of time in minutes respectively that remained to be played in given period</td>
<td align="left">minutes</td>
</tr>
<tr class="odd">
<td align="right">seconds_remaining</td>
<td align="center">the amount of time in seconds respectively that remained to be played in given period</td>
<td align="left">seconds</td>
</tr>
<tr class="even">
<td align="right">short_made_flag</td>
<td align="center">whether a shot is made or missed</td>
<td align="left">character</td>
</tr>
<tr class="odd">
<td align="right">action_type</td>
<td align="center">basketball moves used by players, either to pass by defenders to gain access to the basket, or to get a clean pass to a teammate to score a two pointer or three pointer</td>
<td align="left">character</td>
</tr>
<tr class="even">
<td align="right">shot_type</td>
<td align="center">whether a shot is a 2-point field goal or a 3-point field goal</td>
<td align="left">character</td>
</tr>
<tr class="odd">
<td align="right">shot_distance</td>
<td align="center">distance to the basket(measured in feet)</td>
<td align="left">number(feet)</td>
</tr>
<tr class="even">
<td align="right">x</td>
<td align="center">court coordinates measured in inches where a shot occured</td>
<td align="left">number</td>
</tr>
<tr class="odd">
<td align="right">y</td>
<td align="center">court coordinates measured in inches where a shot occured</td>
<td align="left">number</td>
</tr>
<tr class="even">
<td align="right">team_name</td>
<td align="center">team name</td>
<td align="left">character</td>
</tr>
<tr class="odd">
<td align="right">game_date</td>
<td align="center">data of the game occured</td>
<td align="left">number</td>
</tr>
<tr class="even">
<td align="right">season</td>
<td align="center">season of the game</td>
<td align="left">number</td>
</tr>
<tr class="odd">
<td align="right">opponent</td>
<td align="center">opponent team</td>
<td align="left">character</td>
</tr>
</tbody>
</table>

### Details

-   The data is downloaded from professor Sanchez\`s github repository.
-   The link of the data is :\[<https://github.com/ucb-stat133/stat133-spring-2018/blob/master/data/klay-thompson.csv>)
