{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica-Bold;\f1\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11460\viewh15300\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\b\fs24 \cf0 Sean Lintern\
\
Interview Project
\f1\b0 \
\
### MVVM-C Architecture

View models have a uniform layout, inputs and outputs, this allows looking at a piece of functionality and identifying the inputs/outputs and clearly defining them and giving defined access to the consuming view controller. Inputs define actions, which in the init() function get transformed into outputs, in this example we see the comments view model on view did load, loads the comments from the network and then through the optional outputs binding, relays them to a listener. This also allows 100% test coverage of view models.

Factories are used to construct view models and controller and bind them, we pass a coordinator in to understand the context and handle next events, in this case the factory is very light weight, and you would be able to easily place the comments screen in a different flow through only writing a new factory adaptor to a different coordinator.\

Coordinators utilise an enum based Event state, this allows us to 100% test the flows throughout the app, and allows us to create micro-flows of functionality easily.

Protocols used throughout to obfuscate true implementations.

Network is easily mocked as seen, this would also allow a testing network to be injected, in case we wanted to use an app in a fully offline state we could mock every endpoint in an \'91Offline Network\'92 class and still use an app to full functionality.
