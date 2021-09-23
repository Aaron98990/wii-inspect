# wii-inspect
Prequisite Reading
- [Protecting and Cracking Game Save files](https://medium.com/@pantelis/protecting-game-saves-and-the-case-of-unworthy-e24c8fd68e16)
- Hint: All Wii save files have standardized encryption. After decryption using tachtig from Segher Wii Tools, Wii Sports Resort uses binary.

Prequisite Hadware/Software
- Wii Sports Resort Save Data - if you have played Wii Sports Resort on your wii, you have this
- SD Card
- Wii that has an SD Card slot - not a Wii Mini
- Laptop or laptop extension that has an SD Card slot
- Terminal that runs BASH 5 or later (On Windows, [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) may be needed.)
- gcc, xxd, git

About
- Retrieve high scores, dates of recieved stamps, and the last 25 plays from the save file for Wii Sports Resort.

<img src="https://user-images.githubusercontent.com/45950113/132385115-596b0a18-a88f-4928-987c-d44c3d0fc1d4.png" width="700">
<img src="https://user-images.githubusercontent.com/45950113/132387567-c2bd82f4-63eb-45e0-9eaa-1eec0cc06c0d.png" width="500">
<img src="https://user-images.githubusercontent.com/45950113/132388144-3670090e-17b2-4ed5-a3f2-cee285f81a37.png" width="450">

## Instructions
Retrieving Save File
- For Wii, open the white slot under the reset button and insert an SD Card.
- From the Home Screen on the Wii, click Wii (bottom left) > Data Managment > Save Data > Wii > Choose Game (Umbrella) > Copy

**Deleting a save file will reset the game and remove all scores and progress. Do not click delete.**

**The save file is stored in SD://private/wii/title/RZTE/data.bin. If there is a file already there, change the folder or file name on your laptop to allow for a newer save file to be copied.**

Dowload Wii Segher Tools for Tachtig (and more)
- Type in your terminal: ``cd ~`` then ``git clone https://github.com/Plombo/segher-wii-tools``
- Type in your terminal: `cd segher-wii-tools`, then type ``make all``. If there are problems, type `make clean` then `make all`.
- Type``chmod +x tachtig`` to create an executable file
- Copy the tachtig file to a location in your $PATH with ``sudo cp tachtig /usr/local/bin`` **You must do this**

Transferring the Save File
- Insert the SD Card into a laptop or laptop extension and navigate to SD Card folder
- Rename the `private` folder to today's date and time ``202109071319`` for easy tracking of multiple save files.
- If using WSL or if you would like, copy or move the directory to your laptop and outside the SD Card (like your desktop). 
- If using WSL, do this ``mv /mnt/C/users/aaron/Desktop/202109071319 ~/wii-inspect`` <- Change aaron to your username and make other changes as needed

Using wii-inspect
- Type in your terminal: ``cd ~`` then ``git clone https://github.com/Aaron98990/wii-inspect``
- In the terminal, ``cd wii-inspect`` then type ``bash stamps.bash 202109071319/wii/title/RZTE/data.bin`` and ``bash highScores.bash 202109071319/wii/title/RZTE/data.bin`` <- Change the date and make other changes as needed
- That's all! Enjoy going through history! **Please report any errors (including in README.md) using GitHub's issue function. **

## Extra Information

In the Future?
- View high scores on a per-player bases. I know where it is on the data/game file, I just have not "coded" it.
- Extend stamps to more than three players. Don't show stamps screen for no/empty player.
- Improve formatting and use more for loops. Hard to use for loops, especially when lots of switching between hexadecimal, binary, and decimal.
- Paper or Documentation with analysis of offsets of save data
- In Return Table Tennis, the score freezes at 999 but the game continues. I am curious if the save data continues. 
- Investigating the recommendation system for Wii Sports Resort. I suspect there is a place to keep track of the number of games played but still testing. Note: playing the game once does not necesairly change the recommended game even after restarting.
- Level (0 - 2500) and accomplishments (Superstar or Pro) for games have not been found but I suspect a place.
- Island Flyover Statistics including iPoints, balloons, 8 unlockable achievments, and balloons/iPoints in 5 minutes record.
- Include the **Superstar Score** - the score of a game where a player starts and ends at or as close as possible to Skill Level 2000.

Branches
- Everything is done directly to master. Dev is for my experimentations and will include wacky numbers and be harder to read.

Other Wii Decrypting or Interesting Articles
- Wii Fit Weights https://code.google.com/archive/p/wii-fit-parser/wikis/HowTo.wiki (They used Preon-Java Library)
- https://jansenprice.com/blog?id=9-Extracting-Data-from-Wii-Fit-Plus-Savegame-Files 
- http://wiibrew.org/wiki/FE100 (FE100 is Windows's port of Segher tools)
- http://www.kellbot.com/extracting-graphing-wii-fit-data/
- Keys from the Wii for Segher tools https://hackmii.com/2008/04/keys-keys-keys/
- Skill level is an Elo-style measure of performance when competing against AI oppoent(s) with their own visible skill level. https://arstechnica.com/gaming/2017/04/was-ubers-ceo-really-the-second-best-wii-sports-tennis-player/
- The skill points are a floating point number, of which only its integer part (its floor, i.e. rounded down, not rounded to nearest) is visible. http://orden-y-concierto.blogspot.com/2013/04/wii-sports-tennis-skill-points-system.html
- ELO Rating Elo rating https://metinmediamath.wordpress.com/2013/11/27/how-to-calculate-the-elo-rating-including-example/
**If you have other interesting articles, please open an GitHub Issue and share.**
