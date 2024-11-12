# Woven Weather
**Woven Weather** is a combination of digital embroidery and data visualisation that converts Sydney’s 2023 temperature data into an artistic representation through embroidered hexagons.

Each hexagon, with a centre fill and outer border, represents either the extreme high and low temperatures or the average high and low temperatures of one month. By using hexagonal embroidery patches, this prototype transforms climate data into something tangible, functional, and visually pleasing.

This project not only addresses climate awareness by visually depicting the changes in temperature but also demonstrates the innovative use of technology in traditional textile art.

![Final 365 hexagons](https://github.com/user-attachments/assets/f7a2eaeb-17d9-4b8f-b942-92a97d61c778)
![Final alignment and hexagon next to each other](https://github.com/user-attachments/assets/4063303f-8fb3-4485-bf54-b7c67368df0a)
![v6 24 hexagons](https://github.com/user-attachments/assets/12e3df54-e7d6-413e-b791-bfe323a0d75f)
![IMG_6280](https://github.com/user-attachments/assets/47dfb4d6-39df-423f-9d7e-99c0b06d4ce4)
![IMG_6286](https://github.com/user-attachments/assets/a2a278c4-6680-47d4-83b4-925643124b88)


## Shortcuts
* Instructions for [**Setting Up**](#setup) and [**Running**](#usage) this prototype
* Explore the source code for the prototype
* Read the [**Acknowledgements and References**](#sources) for this project

---

## Table of Contents
* [Motivation](#motivation)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Setup](#setup)
* [Usage](#usage)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)
* [Screenshots](#screenshots)
* [Sources](#sources)

## Motivation

The purpose of this project is to explore the intersection of environmental data and textile art, presenting climate data in a creative and accessible format. The concept was inspired by temperature blankets—functional pieces that have been used to track yearly temperature variations. 

However, my project expands on this by using digital tools, such as Processing and the PEmbroider library, to automate the embroidery process. This approach combines the beauty of handmade textiles with modern data science, aiming to make climate information more meaningful and accessible to anyone. 

My goal is to tell a story about Sydney's changing climate in 2023, through the lens of textile art, while leveraging the efficiency machine embroidery to significantly speed up production compared to traditional hand embroidery methods.


> Colours have always been an effective was to represent varying temperatures, so applying this concept to textile design is a natural progression to me.

> ![Global Temperatures Over Time](https://github.com/user-attachments/assets/99dba175-a978-4a1d-ac66-338cf3288914)

---

### Design Inspiration

* A variety of design examples are on this website: [Stunning Crochet Temperature Blankets](https://patterncenter.com/crochet-temperature-blankets/)

* A Crotcheted 2020 Temperature Blanket by Kaz Hall

> ![2020 Temperature Blanket by Kaz Hall](https://github.com/user-attachments/assets/02292de6-e2b2-4b3f-b959-f9e59933aea8)

* A Crotcheted Hexagon Temperature Blanket

> ![Crocheted Hexagon Blanket](https://github.com/user-attachments/assets/759fbca3-74a5-4ed5-a7f1-e6e677844596)

* A Hand Embroidered Circular Temperature Blanket

> ![Embroidered Temperature Blanket](https://github.com/user-attachments/assets/13753a3d-0952-4969-ac43-f0d7a54fe0e4)

## Technologies Used

### Technologies

![image](https://github.com/user-attachments/assets/52eff832-b7b1-442e-afa8-25027081c886)
* Python- Version 3.12.5
  
![image](https://github.com/user-attachments/assets/c383ad88-3e3c-49fa-bc47-03d2d83e6c84)
* Processing - Version 4.3
  
![image](https://github.com/user-attachments/assets/45f195f1-823d-41ac-b436-ecc5eb3a229f)
* PEmbroider Library - Last Updated 3 Years Ago
  
![image](https://github.com/user-attachments/assets/d1f46884-b1d4-4b09-bb6e-4e4f6c166346)
* Brother Computerized Sewing and Embroidery Machine with 4" x 4" Embroidery Area - Model SE425 

### Materials

* Embroidery Thread - SimThread 63 Spools Polyester Embroidery Thread
* Cotton/Poplin white fabric (not too thick or stretchy)
* Tear-away fabric backing for machine embroidery
* Scissors
* Bobbins preloaded with white thread, that matches the machine model

 ![Embroidery Thread Colours](https://github.com/user-attachments/assets/654a74ba-03f6-4807-bbd6-ea1d9ce1c39f)

## Features

**Woven Weather** includes the following key features:

* **Automated Embroidery of Temperature Data**: Using Processing and the PEmbroider library, this project automates the translation of climate data into embroidery patterns, making the process very efficient.
  
* **Assigning Colours to the Temperature Data**: Each hexagon in this project visualises temperature data from Sydney 2023, using a colour code ranging from cool blues and purples for lower temperatures to warm oranges and reds for higher temperatures. The colors are applied through the embroidery machine's instructions, which are converted from Processing code.

* **Multilayered Polygon Generation**: The prototype generates consistent, uniform hexagons through trigonometric calculations, a shape that is currently missing from the PEmbroider library [**Examples**](examples/README.md). These hexagons are sized and positioned to fit neatly within a 4x4-inch embroidery hoop, balancing the aesthetics and ensuring effective use of space.

* **Seasonal Stitch Integration**: Eight different types of stitches were integrated to convey seasonal changes. These include combinations of border and center stitches to symbolise the unique characteristics of each season, such as zigzag stitches for summer to represent the crazy heat and cross-stitches for winter, kind of reminiscent of snowflakes.

* **Alignment Dots for Accuracy**: To make sure there was precise stitching during assembly of the full prototype, alignment dots are added around each set of four hexagons. These dots are used for positioning the fabric correctly during the embroidery process, when the design as to be split into separate code due too limitations of the embroidery hoop size. Multiple functions were implemented for embroidering and printing these alignment dots to ensure consistency.


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
* In the Brother SE425's digital display, run the code for alignment dots
* Leave the hoop in and then run the code for the first four hexagons
* Then, take the hoop out, and use the printed alingment dots to perfectly position the next part of the fabric
* Run the alingment dots and next four hexagons
* Repeat until finished!

## Project Status

![image](https://github.com/user-attachments/assets/56469b87-1237-432a-b730-f73824493dc5)

Project is in progress, having only embroidered 12 out of 24 hexagons, due to time constraints, unexpected issues and frequent adjustments in the code to accommodate for the machine's capabilities. 

### To do:
* The alignment dots need to be stitched on and printed out to ensure the next set of hexagons are precisely placed. 
* All 24 hexagons need to be embroidered together

## Room for Improvement

### Borders and Grids

* Perhaps adding borders, grids or other design elements would benefit the prototype's aesthetic. For example, having a thin border around each month (vertical pair of hexagons) could provide an opportunity to add seasonal motifs.
* E.g. summer: the border could have shining sun rays or water in simple lines, autumn: cascading leaves around the border, spring: flowers blooming out of the border, winter: clouds/snow or other winter motifs attached to the border.
* From exploring PEmbroider, I would likely build on from these examples:
#### PEmbroider_lines_1
Lines with varying stroke weight. Lines with varying stroke spacing.
Lines with varying stitch lengths. Lines with tangent versus parallel stitches.
[![](PEmbroider_lines_1/documentation/PEmbroider_lines_1_photo.png)](PEmbroider_lines_1/)
#### PEmbroider_lines_2
Curves and line segments.
[![](PEmbroider_lines_2/documentation/PEmbroider_lines_2_photo.png)](PEmbroider_lines_2/)
#### PEmbroider_ruler
Test your units. 
[![](PEmbroider_ruler/PEmbroider_ruler_photo.png)](PEmbroider_ruler/)

### Text

* Adding text would make the design more easily understandable, especially if each month was labelled or if in the corner it stated "Sydney 2023" to be specific on what the blanket is based off.
* After exploring PEmbroider, I would rely on these resources
#### PEmbroider_text_1
High-quality stroked and/or filled letterforms, from TrueType fonts.
[![](PEmbroider_text_1/PEmbroider_text_1_photo.png)](PEmbroider_text_1/)
#### PEmbroider_text_2
Options for high-quality type alignment (baseline, ascent, descent; left, center, right). 
[![](PEmbroider_text_2/PEmbroider_text_2.png)](PEmbroider_text_2/)
[![](PEmbroider_text_2/PEmbroider_text_2_photo.png)](PEmbroider_text_2/)
#### PEmbroider_text_3
Built-in implmentations of [Hershey fonts](https://en.wikipedia.org/wiki/Hershey_fonts) (single-stroke vector fonts) for quick embroidered typography without font rasterization. 
[![](PEmbroider_text_3/PEmbroider_text_3_photo.png)](PEmbroider_text_3/)
#### PEmbroider_optimize_per_char
Demonstration of an optional feature which optimizes the embroidery of filled text on a per-character basis.
[![](PEmbroider_optimize_per_char/documentation/PEmbroider_optimize_per_char.png)](PEmbroider_optimize_per_char/)


## Screenshots


![IMG_6286](https://github.com/user-attachments/assets/997bf8c2-4417-45fa-a6ac-56533f48fe94)
![IMG_6280](https://github.com/user-attachments/assets/a613b712-cfbe-4a6d-ba55-f91e32b743f4)
![IMG_6146](https://github.com/user-attachments/assets/2205a8f3-2589-412c-98c9-053cf5da58d8)
![IMG_6138](https://github.com/user-attachments/assets/9d53e63f-6ad7-4c4e-8f00-f8e3f33fe486)
![IMG_6121](https://github.com/user-attachments/assets/77b6f7e8-f336-4d92-a168-829386315579)
![IMG_6109](https://github.com/user-attachments/assets/5f31778d-979f-4f24-838b-0907f2da5363)
![IMG_6039](https://github.com/user-attachments/assets/af5573ff-ae9e-43e0-9afc-fa6e3f91b5b6)



## Sources

References
Berry, D. M. (2011). What is Code? In The philosophy of software (pp. 29–36). Palgrave Macmillan UK eBooks. https://doi.org/10.1057/9780230306479
Course Literature
Corporation, V. C. (n.d.). Weather Query Builder. Weather Data Services | Visual Crossing. Retrieved September 30, 2024, from https://www.visualcrossing.com/weather/weather-data-services/Sydney?v=api
Independent Resource
De Silva, K. (2023, June 29). OOP Concepts: Mastering Basics with Real-Life Examples for Easy Understanding. Medium. https://medium.com/@kalanamalshan98/oop-concepts-mastering-basics-with-real-life-examples-for-easy-understanding-part-1-da5b8fc21036
Course Literature
Eisenberg, J. D. (n.d.). 2D Transformations. Processing. Retrieved October 6, 2024, from https://processing.org/tutorials/transform2d
Tutorial
Ford, P. (2015, June 11). What Is Code? If You Don’t Know, You Need to Read This. Bloomberg.com. https://www.bloomberg.com/graphics/2015-paul-ford-what-is-code/
Course Literature
Fry, B. (2007). Processing Overview. Processing. Retrieved September 25, 2024, from https://processing.org/tutorials/overview
Tutorial
Gelal, O. (2015a, November 27). Ultimate Guide to the Processing Language Part I: The Fundamentals. Toptal Engineering Blog. https://www.toptal.com/game/ultimate-guide-to-processing-the-fundamentals
Gelal, O. (2015b, December 17). Ultimate Guide to the Processing Language Part II: Building a Simple Game. Toptal Engineering Blog. Retrieved September 25, 2024, from https://www.toptal.com/game/ultimate-guide-to-processing-simple-game
Tutorial
HappyCoding.io, & Workman, K. (2016). Processing Tutorials. Happy Coding. Retrieved October 5, 2024, from https://happycoding.io/tutorials/processing/
Tutorial
HOSTINGER. (n.d.). JSON Cheat Sheet. In Three. Two. Online. https://cdn.hostinger.com/tutorials/pdf/JSON-Cheat-Sheet.pdf
Course Resource
Kuniavsky, M. (2010). User experience design for ubiquitous computing. Interactions, 15(6), 20–22. https://doi.org/10.1145/1409040.1409045
Course Literature
Levin, G., Huang, L., Mustakos, T., & Moore, D. (2020). PEmbroider [Software]. In GitHub. Frank-Ratchye STUDIO for Creative Inquiry. https://github.com/CreativeInquiry/PEmbroider
Imported Library
Louis. (2016, June 19). Tinkering in Processing - Drawing a Hexagonal Grid. Louis Christodoulou. Retrieved October 3, 2024, from https://louisc.co.uk/?p=2554
Independent Resource
Mayer-Schönberger, V., & Cukier, K. (2013). Big Data: A Revolution that Will Transform how We Live, Work, and Think (Issue 9, p. 189). Houghton Mifflin Harcourt. https://doi.org/10.25009/clivajes-rcs.v0i9.2536
Course Literature
Pazos, A. (n.d.). Processing. Fun Programming - Creative Coding Video Tutorials. Retrieved September 25, 2024, from https://funprogramming.org/
Tutorial
Reas, C., & Fry, B. (2014). Arrays. In Processing: A Programming Handbook for Visual Designers, Second Edition. The MIT Press. https://processing.org/tutorials/arrays
Tutorial
Reas, C., & Fry, B. (2015). Getting started. Processing. Retrieved September 27, 2024, from https://processing.org/tutorials/gettingstarted
Tutorial
r/Machine_Embroidery: HELP I bought this embroidery machine thinking I could do large embroidery patterns. (2022). Reddit. Retrieved November 6, 2024, from https://www.reddit.com/r/Machine_Embroidery/comments/18hq4kg/help_i_bought_this_embroidery_machine_thinking_i/
Independent Resource
Shiffman, D. (n.d.). PShape. Processing. Retrieved September 26, 2024, from https://processing.org/tutorials/pshape
Tutorial
Shiffman, D. (2008a). Color. Processing. Retrieved October 1, 2024, from https://processing.org/tutorials/color
Tutorial
Shiffman, D. (2008b). Coordinate System and Shapes. Processing. Retrieved September 27, 2024, from https://processing.org/tutorials/coordinatesystemandshapes
Tutorial
Shiffman, D. (2008c). Objects. Processing. Retrieved September 30, 2024, from https://processing.org/tutorials/objects
Tutorial
Shiffman, D. (2008d). Strings and Drawing Text. Processing. Retrieved October 7, 2024, from https://processing.org/tutorials/text
Tutorial
Shiffman, D. (2008e). Two-Dimensional arrays. Processing. Retrieved October 5, 2024, from https://processing.org/tutorials/2darray
Tutorial
Using Alignment Stitches. (n.d.). Retrieved November 6, 2024, from https://urbanthreads.com/learn/how-to/using-alignment-stitches-machine-embroidery#
Independent Resources
Van Dijck, J. (2014). Datafication, dataism and dataveillance: Big Data between scientific paradigm and ideology. Surveillance & Society, 12(2), 197–208. https://doi.org/10.24908/ss.v12i2.4776
Course Literature

