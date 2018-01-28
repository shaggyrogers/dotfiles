#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
"""
%FILEHEADING%
%FILEHEADINGULINE%

  Version:               1.0.0
  Author:                %USER%
  Creation Date:         %DATE%
  License:               %LICENSE%

  Description
  -----------
  Contains all logging functionality.

  Usage
  -----
  1. Import, create a logger
      import Logger
      log = Logger.Logger()

  2. Set configuration settings
      log.outputVerbosity = Verbosity.Info
      log.inputVerbosityDefault = Verbosity.Info
      log.logfile = True
      log.logfilePath = "debug.log"
      log.stdout = True

  3. Write to log file
      log.log("Default")
      log.log("Error", Logger.Verbosity.Error)

  TODO
  -----
  * Add print monkey-patching option for drop-in logging
  * Add singleton option
  * Add option to write to arbitrary files

std library has logging  - make this a wrapper?
"""
# Standard python modules
import inspect
from Queue import Queue
import threading
import time

# Verbosity levels
class Verbosity:
    Max = 4
    Debug = 4
    Info = 3
    Warning = 2
    Error = 1
    Fatalerror = 0
    Min = 0

    @staticmethod
    def getName(level):
        __LevelNames = { 4 : "DEBUG",
                     3 : "INFO ",
                     2 : "WARN ",
                     1 : "ERROR",
                     0 : "FATAL",
                     }

        return __LevelNames.get(level)

# Default Configuration
OutputVerbosityDefault = Verbosity.Info
InputVerbosityDefault = Verbosity.Info
StdoutDefault = True
LogfileDefault = True
LogfilePathDefault = "debug.log"

# Class definition
class Logger:
    """
    Logger class.

    Features
    ---------
    * Easy configuration
    * Verbosity control
    * Automatic file, function and line number output
    * Time and date prefix
    * Output to a log file and/or stdout

    Attributes
    ----------

    outputVerbosity : int
      Verbosity level, controls the level of detail to log.

    logfile : bool
      Controls whether the logger writes to the log file. Default is True.

    logfilePath : string
      Path to the log file. May be None if log file is disabled. Default is "debug.log".

    stdout : bool
      Controls whether the logger prints to stdout. Default is True.

    """

    def __init__(self):
        """
        Initialises a newly created instance of this class.
        """
        # Set default configuration
        self.outputVerbosity = Verbosity.Info
        self.inputVerbosityDefault = Verbosity.Info
        self.logfile = True
        self.logfilePath = "debug.log"
        self.stdout = True

    def log(self,
            debugStr,
            debugLevel = None):
        """
        Adds a prefix with file, function and line number to debugStr, and if the debug
        level is high enough, outputs to stdout and/or the log file.

        Arguments
        ---------
        debugStr : string
          The string to output to the log file.

        debugLevel : int
          The debug level,

        """

        assert debugLevel is None or (debugLevel >= Verbosity.Min and debugLevel <= Verbosity.Max)
        assert isinstance(debugStr, str)

        if debugLevel is not None and debugLevel < self.outputVerbosity:
            return

        # Get file name, function name and line number
        callerStack = inspect.stack()[1]
        callerFrame = callerStack[0]
        info = inspect.getframeinfo(callerFrame)
        fileName = info.filename
        funcName = info.function
        lineNum = info.lineno
        verbosityStr = ""

        # Verbosity name
        if debugLevel is not None:
            verbosityStr = Verbosity.getName(debugLevel)

        # Get timestamp
        datetimeStamp = time.strftime("%Y-%m-%dT%H:%M:%S")


        # Write debug string
        debugStr = "[{DateTime} {Verbosity} {File} {Function} {Line}] {Str}".format(
                DateTime=datetimeStamp, File=fileName, Function=funcName, Line=lineNum,
                Str=debugStr, Verbosity=verbosityStr)

        # Output to stdout
        if self.stdout:
            print(debugStr)

        #Output to file
        if self.logfile:
            try:
                with open(self.logfilePath, "a") as fileOut:
                    fileOut.write(debugStr+"\n")
            except Exception as e:
                errSummary = ("[{DateTime} debugLog] Failed to write to debug log "
                                  "(Error: \"{E}\")".format(
                                      N=e.__class__.__name__,E=str(e),
                                      DateTime=datetimeStamp))
                print(errSummary)
