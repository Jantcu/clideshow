#!/bin/bash

function clideshow_help() {
  echo "Available commands:"
  echo "present"
  echo "generate"
}

function clideshow_present() {
  # Make sure the user input is an actual system file path.
  if [ ! -f $1 ]; then
    # Inform the user of the path mistake and exit.
    echo "No file found at $1"
    exit
  fi
  # Break the file into a SLIDES array by each new line.
  readarray SLIDES < $1
  # Loop through the newly created SLIDES array.
  for (( i = 0; i < ${#SLIDES[*]}; ++ i )); do
    # Left (h) or Up (k) is pushed. 
    if [ "$key" = 'h' ] || [ "$key" = "k" ]; then
      echo "Previous Slide: LEFT or DOWN arrow pushed"
      # Check if this slide bundle is not already at the beginning of the presentation.
      if [ $(($i-3)) -gt 0 ]; then
        # Set the position for the previous slide.
        i=$(($i-4))
      else
        echo "Already at first slide"
        # There are no slides before the first slide, so just stay where you are.
        continue
      fi
    # Right (l) or Down (j) is pushed. 
    elif [ "$key" = 'l' ] || [ "$key" = "j" ]; then
      echo "Next Slide: RIGHT or DOWN arrow was pushed"
      # If the current array bundle is greater than or equal to the entire slideshow length.
      if [ $(($i+3)) -ge ${#SLIDES[*]} ]; then
        # Notify that we're already at the last slide.
        echo "Already at last slide"
        # Reset to the top of this slide bundle.
        i=$(($i-3))
      fi
    elif [ "$key" ]; then
      echo "$key is not a valid command. Please use 'h' or 'l' to navigate through slides."
      # If a non-valid command is used, do not do anything.
      continue
    fi
    # If a moving to a new slide (indicated with three hyphens: ---).
    if [[ ${SLIDES[$i]} == *"---"* ]]; then
      # Clear the screen for new slide content.
      clear
      # Print a horizontal line.
      stty size | perl -ale 'print "-"x$F[1]'
      # Print the slide title.
      figlet ${SLIDES[$i+1]}
      # Print the slide content.
      figlet -f straight ${SLIDES[$i+2]}
      # End with another printed horizontal line.
      stty size | perl -ale 'print "-"x$F[1]'
      # Look for user input to advance to the next slide.
      read  -n 1 -p "'h'=previous | 'l'=next:" key
    fi
  done
}

###############################################
### Below is the engine that runs clideshow ###
###############################################

# Get the user input
command=$1
arg=$2
# Check to see if user actually gave input
if [[ -n "$command" ]]; then
  # The user passed the help command.
  if [[ $command == "help" ]]; then
    # Run clideshow_help function.
    clideshow_help
  # The user passed the present command.
  elif [[ $command == "present" ]]; then
    # Check that the user specified where the slides are located.
    if [[ -n "$arg" ]]; then
      # Run clideshow_present function and pass the slides.
      clideshow_present $arg
    # If no slides were sent.
    else
      echo "Please specify where your slides are located. For example: \"clideshow present /path/to/my/slides\""
    fi
  # The user did not match any clideshow commands.
  else
    echo \"$command\" is not a valid command. Please use \"clideshow help\" to see what is available.
  fi
# The user did not give any input.
else
  # Add line break.
  echo $'\r'
  # Send welcome message.
  echo "Welcome to CLIdeshow! Need help getting started?"
  # Add line break.
  echo $'\r'
  # Show help screen.
  clideshow_help
  # Add line break.
  echo $'\r'
fi
