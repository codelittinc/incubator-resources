Design Processes
========

- We upload all our work to out encrypted Sync server. Non-final files are files that don’t have the finalized design but might need to be reached by others in the team, and are stored in a WIP (work in progress) folder. Final files should be saved in a Final folder (please refer to Sync section in this file for further details).

- Trello cards should have corresponding PDFs attached to them to help devs find things.


##Illustrator

- We work primarily on Illustrator, in conjunction with Photoshop for anything bitmap related. This application has a lot of gains in our line of work: first off, multiple artboards. You could argue that a PSD file has layers, but it’s not the same thing. Artboards allow you to see the entire project displayed at once, without having to go activating and deactivating different layers. Another positive attribute is that Illustrator works with vectors, so there’s no limit to the resolution of the source files. Monitors keep increasing their resolutions and soon designing for those will mean hefty PSD files, which isn’t the case on Illustrator.

- Set your files to **RGB** (always, unless it’s a file that will be printed in which case it should be CMYK) at **300dpi**. For ease of use, make sure that Alignment to Pixel Grid is unchecked in your settings.

- Working at 300dpi can be deceiving, especially when considering lower resolution screens. To check your work go to View > Pixel Preview, make sure to be at 100% zoom, and see if anything needs adjusting for proper rendering to occur in lower res screens.

- Mockups for desktop are done at **1600px** width, and for mobile at **320px** width to account for the narrowest screens (iPhones, usually).

- **Pixels can’t be divided.** Elements sizes (lines, boxes, images, text boxes, circles, you name it) must be whole numbers. Be careful when drawing lines: lines in 0.5pt might look nice in Illustrator but devs will have to code it to the nearest pixel, which would be 1, doubling your original design.

- Illustrator can render many different shades of grey, but not so much low resolution screens. Designers should try and stick to a few to guarantee appropriate rendering of design choices in as many devices as possible.
  
  
##Getting files to engineers

A lot can go unsaid or forgotten when talking about projects. We spend some time preparing files so that they’re easy to understand for developers. This includes adding small descriptions where necessary outside of the artboards as guides for devs to follow. This could include a link to an animation or transition, explaining the logic of a grid, showing the different statuses of a CTA, etc. This space is used for internal communication and devs know to look out for it.

- Designers should try and make time to prepare a style sheet for developers. It can include:

  - visualization of 3 statuses of CTAs: inactive, hover, active

  - color palette

  - typographic families used

  - main type values / weights

  - any extras to help devs

- Lines and anything with a stroke need to be expanded before sending files over to developers. 
  

##General web stuff

- Icons must be saved as SVG, and exported as PNG at normal resolution and x2. (SVGs are vectors and can scale, 1 file per SVG is fine).

- When saving icons in SVG, the designs need to be expanded (not in strokes) and as simplified as possible to reduce file size or any possible problem in rendering.

- Photos / large scale backgrounds should be saved in JPEG at 72dpi resolution in the following sizes:

  - **1600px** wide (desktop)

  - **2400px** wide (desktop retina screens)

  - **320px** wide (mobile)

  - **640px** wide (higher res mobile devices)

- Typography: make sure any typographies used in projects are available to devs in www.typekit.com

- Typographic sizes: anything above 15px is on the safe zone. Anything smaller than 15px could be rendered poorly on low resolution screens. Designs could get away for 12px size fonts for legal text, footers, disclaimers, etc.

- To ensure good readability the padding around default text on input fields should be 10px at the bare minimum.

- Research says that on mobile the correct clickable area for a CTA should be no less than 40px. Anything smaller runs the risk of being too small for the average sized finger to press.
  

##Sync

- The latest Illustrator files should be tagged RED, accompanied by its PDF tagged in ORANGE (any other color tags are used internally by the design team, for example files known to be corrupted are tagged in yellow). Most of us are on macs and should be able to see the tags. To help those who aren’t, include the date the file was created to the end of your file name, for example:

“Codelitt-Incoin-Employee Accounts-140513.ai”, which breaks down to

Codelitt - Project Name - Specific Feature - ddmmyy (without the spaces in between the dashes)

  

- We divide folder structure like so:

        // Project X

          // Design

            // WIP (work in progress)

              // IMGs

                // PNGs

                // SVGs

              // Feature 1 (App, Test Harness, Emails, etc)

                Codelitt-Project X-Feature 1-WIP-ddmmyy.ai

                Codelitt-Project X-Feature 1-WIP-ddmmyy.pdf

              // Feature 2 (App, Test Harness, Emails, etc)

                Codelitt-Project X-Feature 2-WIP-ddmmyy.ai

                Codelitt-Project X-Feature 2-WIP-ddmmyy.pdf

          

            // Final

              // IMGs

                // PNGs

                // SVGs

                // JPEG

              // Feature 1

                Codelitt-Project X-Feature 1-ddmmyy.ai

                Codelitt-Project X-Feature 1-ddmmyy.pdf

  
##Emails

Emails are coded in HTML with inline CSS only, meaning there are several restrictions designers need to keep in mind in order for the final result to look like what was planned and approved.

**Designs must be thought out as blocks, without use of transparencies or gradients, nor superposing or overlapping.**

- Use Helvetica or Arial fonts, only.

- Emails should be 600px wide to ensure maximum compatibility with email providers.

- Background images should be avoided.

- Logos need to be exported in GIF or PNG format at 72dpi.

- Icons need to be imported in PNG format at 72 dpi.

- Photos need to be imported in JPEG format at 72 dpi.

- All images should be the exact size they need to appear on the email.
  

##Photography repo

- Death to the stock photo - [www.deathtothestockphoto.com](http://www.deathtothestockphoto.com)

- Unsplash - [www.unsplash.com](http://www.unsplash.com)

- Twenty20 - [www.twenty20.com](http://www.twenty20.com)
  

##Design inspiration repo

- Dribble -[www.dribbble.com](http://www.dribbble.com/)

- Behance -[www.behance.com](http://www.behance.com/)

- Awwwards -[www.awwwards.com](http://www.awwwards.com/)

- One Page Love (one page websites) -[www.onepagelove.com](http://www.onepagelove.com/)
  

##Animations / transitions research

- Codepen -[www.codepen.io](http://www.codepen.io/)

- Codrops -[www.tympanus.net/codrops](http://www.tympanus.net/codrops)

  
  

------ 

For more info on our product design process check out: [8 Steps to Software/Web Product Design](http://www.codelitt.com/blog/8-steps-to-product-design/)

For more info on general UX check out: [A few Simple Goals to Deliver Great UX](http://www.codelitt.com/blog/a-few-simple-goals-to-deliver-great-ux/)

For more information on foundations of a good UI checkout: [Foundations of a Good UI](http://www.codelitt.com/blog/the-foundations-of-a-good-ui/)
