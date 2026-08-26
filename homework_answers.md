# 611 Data Science Homework

## Problem 1

The new behavior is caused by `alias`. An alias gives a short name to another command or command phrase.

For example:

```bash
alias hello="echo hello world"
hello
```

Even though `hello` is not a file on the path, the shell first checks whether the command word is an alias. Since `hello` is an alias, the shell replaces it with:

```bash
echo hello world
```

Then it evaluates that command.

So I would modify my evaluation strategy like this: before searching for a command on the PATH, the shell checks whether the first word is an alias. If it is, the shell expands the alias and then evaluates the resulting command.

## Problem 2

For:

```bash
alias zz=zz
zz
```

I expect an error message like:

```text
zz: command not found
```

This suggests that alias expansion does not create a real command. It only substitutes text. It also suggests that bash prevents infinite alias recursion. In other words, `zz` does not keep expanding into `zz` forever.

For:

```bash
alias aa=bb
alias bb=aa
aa
```

I expect this to produce a command-not-found error, not an infinite loop. The shell may expand `aa` to `bb`, and `bb` back to `aa`, but it keeps track of aliases already expanded on the current command line and prevents infinite recursion.

## Problem 3

I created a file called `experiment.sh`:

```bash
#!/bin/bash
echo "argument number one is $1"
echo "argument number two is $2"
echo "rest of the arguments ${@:3}"
echo "all arguments $@"
```

Then I ran:

```bash
chmod u+x ./experiment.sh
./experiment.sh a b c d e
```

The important rule is that when a shell script is run with arguments, bash stores those arguments in positional parameters.

`$1` is the first argument, `$2` is the second argument, `${@:3}` means all arguments starting with the third argument, and `$@` means all arguments.

So the script receives:

```text
$1 = a
$2 = b
${@:3} = c d e
$@ = a b c d e
```

## Problem 4

The first line:

```bash
#!/bin/bash
```

is called a shebang. It tells the operating system which program should interpret the script.

Its purpose is to make sure that when I run:

```bash
./experiment.sh
```

the operating system uses `/bin/bash` to run the file. Without this line, the script might be interpreted by a different shell, or it might not run the way I expect.

## Problem 5

I invoked the script like this:

```bash
bash ./experiment.sh a 'b c' d
```

The new rule is that quotes affect how the shell splits text into arguments. Spaces usually separate arguments, but text inside quotes is kept together as one argument.

So the script receives three arguments:

```text
$1 = a
$2 = b c
$3 = d
```

The quoted string `'b c'` is one argument, not two.

## Problem 6

In a Dockerfile, `RUN` and `CMD` are different.

`RUN` executes during the image build process. It runs a command and saves the result into the image. For example, `RUN apt update && apt install -y man-db` installs software while the image is being built.

`CMD` does not run during the image build. Instead, it specifies the default command to run when a container starts from the image. If a Dockerfile has more than one `CMD`, only the last one takes effect.

So the short version is: `RUN` is for building the image, and `CMD` is for running a container from the image.

Reference: https://docs.docker.com/reference/dockerfile/

## Problem 7

`apt` is the package manager for Ubuntu and Debian Linux systems. It installs system-level software, such as `git`, `curl`, `man-db`, compilers, and Linux libraries.

`pip` is the package manager for Python. It installs Python packages, such as `numpy`, `pandas`, `matplotlib`, and `requests`.

`install.packages` is an R function for installing R packages, usually from CRAN. For example, `install.packages("tidyverse")` installs the R package `tidyverse`.

## Problem 8

I created this Dockerfile:

```dockerfile
FROM rocker/rstudio

RUN apt update && apt install -y \
    man-db \
    manpages \
    manpages-dev \
    && rm -rf /var/lib/apt/lists/*

RUN yes | unminimize
```

This Dockerfile starts from the `rocker/rstudio` image. It uses Ubuntu's package manager, `apt`, to install manual-page tools and manual-page content.

`man-db` provides the `man` command and manual page database. `manpages` and `manpages-dev` provide manual-page content. The command `yes | unminimize` automatically answers yes to the `unminimize` script, because Docker build steps cannot easily handle interactive input.

## Problem 9

I wrote this bash script:

```bash
#!/bin/bash

for cmd in man ls find
do
  lines=$(man "$cmd" | wc -l)
  echo "$cmd,$lines"
done | sort -t, -k2 -g -r
```

The script loops over the commands `man`, `ls`, and `find`. For each one, it runs `man "$cmd"` to print the manual page. Then it pipes the output into `wc -l` to count the number of lines.

The script prints each result in comma-separated format, like:

```text
find,300
man,200
ls,100
```

Finally, `sort -t, -k2 -g -r` sorts the results by the second comma-separated column, using numeric descending order.

## Problem 10

I created a project directory with these files:

```text
README.md
Dockerfile
experiment.sh
compare_man_pages.sh
homework_answers.md
```

The `README.md` says:

```text
Hi, this is my 611 Data Science Project. More to come.
```

Then I initialized git and committed the files:

```bash
git init
git add -A
git commit -m "First commit."
```

After that, I created a new repository on GitHub and connected my local repository to GitHub.

My GitHub repository link is:

```text
PASTE YOUR GITHUB REPOSITORY LINK HERE
```
