# The Terminal Sunday

> "Remembering that I'll be dead soon is the most important tool I've ever encountered to help me make the big choices in life." - Steve Jobs

![ScreenShot](https://raw.githubusercontent.com/accessd/terminal-sunday/master/img/screenshot.png)

The idea is to provide a graphical and thought-provoking view of one's life span, promoting a reflection on how we spend our time.

## Ruby version

Made initially with Bash, I wrote another version with Ruby language because I love Ruby and to show [Ruby is not dead](https://isrubydead.com/)! :)

## Installation

The script should work on macOS and Linux (The bash script may also work with MINGW).
To use this script, follow the steps below:

1. Download script or clone repository and make sure the script is executable:

```bash
curl -L https://raw.githubusercontent.com/accessd/terminal-sunday/main/terminal_sunday.sh -o "$HOME/terminal_sunday.sh"
chmod +x "$HOME/terminal_sunday.sh"
```

2. Add the script run to the end of .bashrc/.zshrc/etc.

```bash
$HOME/terminal_sunday.sh 1985-06-08 Joe
```

Fish: 

```fish
bash $HOME/terminal_sunday.sh 1985-06-08 Joe
```

Provide your birthdate and name to the script.

You can run it randomly with:

```bash
(( RANDOM%2 == 0 )) && $HOME/terminal_sunday.sh 1985-06-08 Joe
```

Or add sleep && clear after the command

```bash
$HOME/terminal_sunday.sh 1985-06-08 Joe;sleep 1;clear
```

to clear the screen after one second.

You can specify the number of columns by:

```bash
$HOME/terminal_sunday.sh 1985-06-08 Joe 10
```

the main thing is that 80 is divisible without a remainder by this number of columns :)

To make to command more easy to remember you can just add a function to your environment variable file

> If your using mac then it(environment variable file) should be in your home directory called the .bash_profile

> If your using linux ubuntu it(environment variable file) should be in your home directory called the .bashrc

add this code in the bottom of that file :

```bash

life(){
        $HOME/terminal_sunday.sh yyyy-mm-dd your-name
}

```

After adding this function at the end your your .bashrc file . 
You can run the script just by typing "life" in your terminal

```bash

life

```

## Credits

Inspired by [The Last Sunday](https://chromewebstore.google.com/detail/the-last-sunday-reminder/aiojhapcgfgmiacbbjfgedhlcchmpelh?pli=1) chrome extension.

## Contributing

Contributions, ideas, and feedback are welcome. Feel free to fork the repository, make your changes, and create a pull request.
