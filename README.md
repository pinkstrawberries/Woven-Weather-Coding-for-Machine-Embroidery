# Woven Weather
> This project is a combination of digital embroidery and data visualisation that converts Sydney’s 2023 temperature data into an artistic representation through embroidered hexagons. Each hexagon represents one month’s temperature, visualizing extreme lows, highs, and average temperatures.


---
## Shortcuts
* Instructions for [**Setting Up**](#setup) and [**Running**](#usage) this prototype
* Explore the source code for the prototype (include something)
* Read the [**Acknowledgements and References**](#sources) for this project

## Table of Contents
* [General Info](#general-information)
* [Motivation](#motivation)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Setup](#setup)
* [Usage](#usage)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)
* [Screenshots](#screenshots)
* [Sources](#sources)

## General Information
- Provide general information about your project here.
- What problem does it (intend to) solve?

## Motivation

- What is the purpose of your project?
- Why did you undertake it?

![Global Temperatures Over Time](https://github.com/user-attachments/assets/99dba175-a978-4a1d-ac66-338cf3288914)


### Design Inspiration

Many design examples are on this website: [Stunning Crochet Temperature Blankets](https://patterncenter.com/crochet-temperature-blankets/)

A Crotcheted 2020 Temperature Blanket by Kaz Hall

![2020 Temperature Blanket by Kaz Hall](https://github.com/user-attachments/assets/02292de6-e2b2-4b3f-b959-f9e59933aea8)

A Crotcheted Hexagon Temperature Blanket

![Crocheted Hexagon Blanket](https://github.com/user-attachments/assets/759fbca3-74a5-4ed5-a7f1-e6e677844596)

A Hand Embroidered Circular Temperature Blanket

![Embroidered Temperature Blanket](https://github.com/user-attachments/assets/13753a3d-0952-4969-ac43-f0d7a54fe0e4)

## Technologies Used

### Technologies
* Python- Version 3.12.5 ![image](https://github.com/user-attachments/assets/52eff832-b7b1-442e-afa8-25027081c886)
* Processing - Version 4.3 ![image](https://github.com/user-attachments/assets/c383ad88-3e3c-49fa-bc47-03d2d83e6c84)
* PEmbroider Library - Last Updated 3 Years Ago ![image](https://github.com/user-attachments/assets/45f195f1-823d-41ac-b436-ecc5eb3a229f)
* Brother Computerized Sewing and Embroidery Machine with 4" x 4" Embroidery Area - Model SE425 ![image](https://github.com/user-attachments/assets/d1f46884-b1d4-4b09-bb6e-4e4f6c166346)

### Materials
* Embroidery Thread - SimThread 63 Spools Polyester Embroidery Thread
* Cotton/Poplin white fabric (not too thick or stretchy)
* Tear-away fabric backing for machine embroidery
* Scissors
* Bobbins preloaded with white thread, that matches the machine model

 ![Embroidery Thread Colours](https://github.com/user-attachments/assets/654a74ba-03f6-4807-bbd6-ea1d9ce1c39f)

## Features
List the ready features here:
- Awesome feature 1
- Awesome feature 2
- Awesome feature 3


## Setup

### Installation

* Download Python - At least version 3.12.5
* Download Processing - At least version 4.3

  
* PEmbroider Library - [Manually Installed](https://github.com/processing/processing/wiki/How-to-Install-a-Contributed-Library) into Processing by followng these instructions
OR
* **Download** the PEmbroider library [**.ZIP file** for processing 3](distribution/PEmbroider/download/PEmbroider_for_Processing_3.zip) or [for processing 4](distribution/PEmbroider/download/PEmbroider_for_Processing_4.zip)

### Gather Temperature Data

* Create a free account on [Visual Crossing](https://www.visualcrossing.com/sign-up)
* Enter a query on their [Weather API](https://www.visualcrossing.com/weather/weather-data-services/Sydney?v=api) service for the location (Sydney)
* Now your website should look like this:
![Visual Crossing API](https://github.com/user-attachments/assets/e57fa423-664c-4163-83b5-a435123a9bd9)
* Copy the generated code for Python and paste it into a new Sketch file

need to change so it downloads straight onto your computer

### Running Code with Temperature Data

When running this prototype, any code that extracts and processes the temperature data MUST have the file accessible
* In sketch, click the "sketch" drop-down in the top left hand corner
* Select "Add File..."
* When your file directory comes up, navigate until you find where you placed the temperature data
* Upload that file by selecting it
Now you can run any code for this prototype that utilises the temperature data

## Usage

* In processing, run the "Alignment dot point thing"
* Connect the Brother SE425 machine to your files with the HDMI -> USB-B cable that comes with the machine
* In the "Remote Disk" folder, copy your PES. file of "Alignment"
* Leave the cable plugged in the entire time
* In the Brother SE425's digital display, press this icon:
picture of brother directory
* Press the box that appears
* The colour for alignment dots doesn't matter, but it should be dark so it is easy to unpick later
* Press the green arrow button on the machine to begin the embroidery

maybe put in the resources on connecting digital designs to brother? 

After each alignment, leave it in, 
then sew four hexagons
then take out of hoop
use the stitched alignment dots and the printed paper of alignment dots to arrange the next hoop 

repeat until finished 


## Project Status

![image](https://github.com/user-attachments/assets/56469b87-1237-432a-b730-f73824493dc5)

Project is in progress, having only embroidered 12 out of 24 hexagons, due to time constraints, unexpected issues and frequent adjustments in the code to accommodate for the machine's capabilities. 

### To do:
* The alignment dots need to be stitched on and printed out to ensure the next set of hexagons are precisely placed. 
* All 24 hexagons need to be embroidered together

## Room for Improvement

### Borders and Grids

* Perhaps adding borders, grids or other design elements would benefit the prototype's aesthetic. For example, having a thin border around each month (vertical pair of hexagons) could provide an opportunity to add seasonal motifs. E.g. summer: the border could have shining sun rays or water in simple lines, autumn: cascading leaves around the border, spring: flowers blooming out of the border, winter: clouds/snow or other winter motifs attached to the border.
* From exploring PEmbroider, I would likely build on from these examples:
### PEmbroider_lines_1
Lines with varying stroke weight. Lines with varying stroke spacing.
Lines with varying stitch lengths. Lines with tangent versus parallel stitches.
[![](PEmbroider_lines_1/documentation/PEmbroider_lines_1_photo.png)](PEmbroider_lines_1/)
### PEmbroider_lines_2
Curves and line segments.
[![](PEmbroider_lines_2/documentation/PEmbroider_lines_2_photo.png)](PEmbroider_lines_2/)
### PEmbroider_ruler
Test your units. 
[![](PEmbroider_ruler/PEmbroider_ruler_photo.png)](PEmbroider_ruler/)

### Text

* Adding text would make the design more easily understandable, especially if each month was labelled or if in the corner it stated "Sydney 2023" to be specific on what the blanket is based off.
* After exploring PEmbroider, I would rely on these resources
### PEmbroider_text_1
High-quality stroked and/or filled letterforms, from TrueType fonts.
[![](PEmbroider_text_1/PEmbroider_text_1_photo.png)](PEmbroider_text_1/)
### PEmbroider_text_2
Options for high-quality type alignment (baseline, ascent, descent; left, center, right). 
[![](PEmbroider_text_2/PEmbroider_text_2.png)](PEmbroider_text_2/)
[![](PEmbroider_text_2/PEmbroider_text_2_photo.png)](PEmbroider_text_2/)
### PEmbroider_text_3
Built-in implmentations of [Hershey fonts](https://en.wikipedia.org/wiki/Hershey_fonts) (single-stroke vector fonts) for quick embroidered typography without font rasterization. 
[![](PEmbroider_text_3/PEmbroider_text_3_photo.png)](PEmbroider_text_3/)
### PEmbroider_optimize_per_char
Demonstration of an optional feature which optimizes the embroidery of filled text on a per-character basis.
[![](PEmbroider_optimize_per_char/documentation/PEmbroider_optimize_per_char.png)](PEmbroider_optimize_per_char/)


## Screenshots


![Example screenshot](./img/screenshot.png)


## Sources
Give credit here.
- This project was inspired by...
- This project was based on [this tutorial](https://www.example.com).
- Many thanks to...



<!-- Optional -->
<!-- ## License -->
<!-- This project is open source and available under the [... License](). -->

<!-- You don't have to include all sections - just the one's relevant to your project -->
