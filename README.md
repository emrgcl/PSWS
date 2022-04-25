# Powershell n 500 lines Workshop

In this Workshop You will be able to;

- Learn and use the commonly used classes string, int, array, hashtable, pscustomboject, scriptblock, DateTime,TimeSpan, math
- Understand the object oriented approach in Powerhell and expand your programing universe
- Use the lessons learned in real life scenarios like "Reporting expired certificates"
- Import / export data
- Craete advanced functions and manage parameters and risk mitigation options
- Crate your own modules
- Handle errors
- Learn Powershell Remoting

# Content
the content is actually a powershell script around 500 lines here in repository. PSWSin500Lines.ps1.

# Day 1
## Introduction
 
 - Why Powershell ?
 - PowerShell Versions
 - How to Update Powershell?

## Understanding and Discovering Commands AKA CmdLets
- What is a command?
- How do I discover commands?
- How to run a command with proper syntax?
- List commands in Modules

## Objects in Powershell
- What is an object?
- List properties under the hood

## Variables
 - How to crete a variable
 - understand Variable & Object relationship
 - use methods

## String Objects 
- create strings
- use variables in strings (literal and expandable strings), single vs double quotes
- Run commands within strings using Subexpressions and variable subexpressions

## Type Casting
- specify the type of the objects while declaring / creating them
- understand strong or weak type castting methods

## Hashtables
- Learn to create and manage hashtable objects
- Learn query hasthables
- Learn use case scenarios of Hashtables in Powershell

## PsCustomboject
- Learn to create your custom object easily using hashtables.

# Day 2
## Arrays and ArrayLists
- learn to create arrays
- understand array use cases
- learn to create scalable advanced arrays
- learn to operate arrays

# Looping in Arrays and Conditionals
- learn foreach loop and if condition to 

# Introduction to pipelines
- Understand pipeline behaviour
- use pipeline to filter and operate
- send command outputs to other commands

## Arrays to strings, strings to Arrays
- learn to convert arrays to strings or strings to arrays.

## Introduction to Advanced Functions
- Learn how to create your own Advanced Functions
- Use parameter attribute to make mandatory parameters

# Day 3

## static members in Powershell
- learn to discover static members
- use commonly used static members exmple with the math class

## Providers in Powershell - Explore Registry, Certificates etc like exploring a disk
- Understand use of Providers and learn the drives mapped in Powershell
- start exploring drives other than disk (certificaticates, registry etc)

## Select-object in Pipeline
- learn how to cut properties in pipeline
- add your custom property to an existing object using select object and hashtables
- **create a simple script that will report expired certificates**


## Importing from disk
- Importing txt files as objects in Powershell
- Importing CSV files as Objects in Powershell

## Advanced Functions Continued
- Learn how to valdiate parameters
- Use Parametersets to create additional syntaxes
- Risk Mitigation (Confirm, whatif)

# Day 4
## Create your own modules
- learn how to create a module in Powerhell
- Deploy your module
- Modify the default behaviour of your module

## Basic Error Handling in Powershell

- learn how to hadnle errors

## Advanced Error Handling Powershell
- Stop vs continue behavior in error handling
- use try catch finally block to handle errors
- The importance of the finally block

## Remoting in Powershell

- Learn basic / legacy remoting options capatabilites
- use Powershell Sessions for advanced Remoting
- Learn Temporary vs Persistent session differences


# Optional: You can work on the files using Vscdode and Github 

If your IT lets you or if you already have Vscode and Git for windows we can do the workhop using VSCode instead of Powershell ISE.

1. Download and install following files
    - [Download and Install Git For Windows](https://github.com/git-for-windows/git/releases/download/v2.36.0.windows.1/Git-2.36.0-64-bit.exe)
    - [Download and Instasll Vscdode](https://az764295.vo.msecnd.net/stable/dfd34e8260c270da74b5c2d86d61aee4b6d56977/VSCodeUserSetup-x64-1.66.2.exe)

1. Initial Git congiruation: Run the followings for inital git setup
```PowerShell

git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
# below line is only required if you are using a proxy server
git config --global http.proxy http://proxy.server.com:port
```