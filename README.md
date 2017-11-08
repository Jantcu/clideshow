# Clideshow
A script for making CLI Slideshows

![Screenshot of example slide](/assets/img/clideshow.png "Clideshow")

### Dependencies:
You need to have Figlet installed in order to generate the formatted CLI text:
```
sudo apt-get update
sudo apt-get install figlet
```
You also need to install additional fonts from http://www.figlet.org/examples.html

First, Download the fonts: ftp://ftp.figlet.org/pub/figlet/fonts/contributed.tar.gz

Then extract them:
```
tar -zxvf ~/Downloads/contributed.tar.gz -C ~/Downloads/.
```
And make them available to all users on your computer:
```
sudo cp -R ~/Downloads/contributed/* /usr/share/figlet/.
```

See [this helpful guide](https://delightlylinux.wordpress.com/2014/05/30/produce-fancy-text-with-figlet/) for more info.

### Usage
Download this project: https://github.com/Jantcu/clideshow/archive/master.zip

Unzip it:
```
unzip ~/Downloads/clideshow-master.zip -d ~/Downloads/.
```

Run a presentation using the test slides provided:
```
~/Downloads/clideshow-master/clideshow.sh present ~/Downloads/clideshow-master/example_slides
```
