Prequisite Reading for All:
- https://medium.com/@pantelis/protecting-game-saves-and-the-case-of-unworthy-e24c8fd68e16
- Hint: All Wii Save Files have standardized encryption. After decryption using tachtig from Segher Wii Tools, Wii Sports Resort uses binary.

Prequisite Hadware/Software:
- Wii Sports Resort Save Data - if you have played Wii Sports Resort on your wii, you have this
- Wii that has an SD Card slot - not a Wii Mini
- Laptop or laptop extension that has an SD Card slot
- Terminal that runs BASH (On Windows, [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) may be needed. On Mac, zsh is the default.)
- gcc

About:
- Retrieve high scores, dates of recieved stamps, and the last 25 plays from the save file for Wii Sports Resort.

<img src="https://user-images.githubusercontent.com/45950113/132385115-596b0a18-a88f-4928-987c-d44c3d0fc1d4.png" width="700">
<img src="https://user-images.githubusercontent.com/45950113/132387567-c2bd82f4-63eb-45e0-9eaa-1eec0cc06c0d.png" width="500">
<img src="https://user-images.githubusercontent.com/45950113/132388144-3670090e-17b2-4ed5-a3f2-cee285f81a37.png" width="400">

Retrieving Save File
- Open the white slot under the reset button and insert an SD Card
- From the Home Screen on the Wii, click Wii (bottom left) > Data Managment > Save Data > Wii > Choose Game (Umbrella) > Copy

**Deleting a save file will reset the game and remove all scores and progress. Do not click delete.**

**The save file is stored in SD://private/wii/title/RZTE/data.bin. If there is a file already there, change the folder or file name on your laptop to allow for a newer save file to be copied.**

Dowload Wii Segher Tools for Tachtig (and more)
- Create .wii folder in terminal: ``mkdir ~/.wii``
- Create the following files with the text **inside** parentheses - do not include parentheses.  ~/.wii/sd-key (ab01b9d8e1622b08afbad84dbfc2a55d), ~/.wii/sd-iv (216712e6aa1f689f95c5a22324dc6a98) ~/.wii/md5-blanker (0e65378199be4517ab06ec22451a5793).
- Convert the three files above, from hexadecimal into the binary using ``xxd -rb ~/.wii/md5-blanker`` and ``xxd -rb ~/.wii/sd-iv`` and ``xxd -rb ~/.wii/md5-blanker``
- Type in your terminal: ``cd ~`` then ``git clone https://github.com/Plombo/segher-wii-tools``
- Type in your terminal: `cd wii-inspect`, then type ``make all``. If there are problems, type `make clean` then `make all`.
- Type ``chmod +x tachtig`` to create an executable file
- Type ``pwd`` in the terminal for your location from the last step
- To make it easier, you can copy the tachtig file to a location in your $PATH with ``sudo cp tachtig /usr/local/bin`` or add this code to the ``~/.bash_profile`` file or ``~/.bashrc file`` file: ``export PATH=$PATH:~/wii-inspect`` <- Replace ~/wii-inspect with the result of pwd from last step

Transferring the Save File
- Insert the SD Card into a laptop or laptop extension and navigate to SD Card folder
- Change the `private` folder to today's date and time ``202109071319`` for easy tracking of multiple save files. Right click the folder and choose rename.
- If using WSL or if you would like, copy or move the directory to your laptop and outside the SD Card (like your desktop). 
- If using WSL, do this ``mv /mnt/C/users/Aaron/Desktop/202109071319 ~/wii-inspect`` <- Change Aaron to your username and make other changes as needed

Using Wii-Inspect
- In the terminal, ``cd wii-inspect`` then type ``bash ~/wii-inspect/stamps.bash 202109071319/wii/title/RZTE/data.bin`` and ``bash ~/wii-inspect/highScores.bash 202109071319/wii/title/RZTE/data.bin`` <- Change as needed
- It may be easier to add the `stamps.bash` and `highScores.bash` to your path and use better names
- That's all! Enjoy going through history!
- Please report any errors (including in README.md) using GitHub's issue function. Include a screenshot of the terminal results, the mistake, and what you believe the correction should be.

Extra Information

In the Future?
- View high scores on a per-player bases. I know where it is on the data/game file, I just have not "coded" it.
- Extend stamps to more than three players. Don't show stamps screen for no/empty player.
- Improve formatting and use more for loops. Hard to use for loops, especially when lots of switching between hexadecimal, binary, and decimal.
- Paper or Documentation with analysis of offsets of save data
- In Return Table Tennis, the score freezes at 999 but the game continues. I am curious if the save data continues. 
- Investigating the recommendation system for Wii Sports Resort. I suspect there is a place to keep track of the number of games played but still testing.
- Level (0 - 2500) and accomplishments (Superstar or Pro) for games have not been found but I suspect a place.
- Island Flyover Statistics including iPoints, balloons, 8 unlockable achievments, and balloons/iPoints in 5 minutes record.

Branches
- Everything is done directly to master. Dev is for my experimentations and will include wacky numbers and be harder to read.

Other Wii Decrypting or Interesting Articles
- Wii Fit Weights https://code.google.com/archive/p/wii-fit-parser/wikis/HowTo.wiki (They used Preon-Java Library)
- https://jansenprice.com/blog?id=9-Extracting-Data-from-Wii-Fit-Plus-Savegame-Files 
- http://wiibrew.org/wiki/FE100 (FE100 is Windows's port of Segher tools)
- http://www.kellbot.com/extracting-graphing-wii-fit-data/
- Keys from the Wii for Segher tools https://hackmii.com/2008/04/keys-keys-keys/
