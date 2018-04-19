# Hands-on:  dates

Dates are weird![^5] Or, more accurately, [Time](http://www.newyorker.com/magazine/2016/12/19/the-secret-life-of-time) is philosophically fascinating and sometimes difficult to represent.  This is true for your brain and it's especially true for your computer.  Keep in mind that converting dates (i.e. using the `toDate()` function) format sometimes results in errors because time and date formats are weird.  

Often, in OpenRefine, it’s easiest to operate on strings and convert to dates (or to numbers) as needed.  For example, sometimes it’s easier to use a `slice()` of a string and then convert to date, or to number if you really need to do so.  

However, in OpenRefine, the date format is necessary for date faceting and for finding the difference between two dates (e.g. using the `diff()` function, or for getting a `datePart()` for retrieving an hour, or second).

This project will give you practice manipulating dates

## Dates

1. Open the existing Refine Project `Raleigh Building Permits`, (from [Project 1](start.html))
2. Make a copy of the issue_date column  
    + <span class="or-menu">issue_date > Edit column > Add column based on this column…  </span>   
        + <span class="or-menu">new column name = `date2` > OK  </span>   
3. Create a customized facet on AM/PM  
    + <span class="or-menu">issue_date > Facet > Custom text facet …  </span>   
        + Expression = `value.slice(20,22)`  
4. Create a customized facet on the hour  
    + <span class="or-menu">issue_date > Facet > Custom text facet…  </span>  
        + Expression = `value.slice(10,13)`  
5. Convert to Date  
    + <span class="or-menu">date2 > Edit cells > Common transforms > To Date  </span>  
    
    > The status message indicates 19598 rows were transformed, but there are 21982 rows of data, what went wrong?
    
    + Select the “PM” custom text facet and the “12” custom text facet  
        + Do you see that none of the dates converted when the time included 12PM?  
        + For whatever reason, the date converter doesn’t like timestamps that contain 12PM as a designation  
        + So let’s convert those dates from 12PM to 00PM (Why?  because it fixes the problem)  
6. Convert 12PM to 00PM  
    + <span class="or-menu">date2 Edit cells > transform  </span>  
        + Expression = `value.replace(" 12:"," 00:")`
7. Now convert to date  
    + <span class="or-menu">date2 > Edit cells > Common transforms > To Date  </span> 
    
    > That converts 2384 cells 
    
8. Now, `Remove All` facets

8. Now make a date facet  
    + <span class="or-menu">date2 > Facet > Timeline facet </span> 


## Logic  

This time we'll put together everything we've learned (how to use OpenRefine, regular expressions, GREL) and add in some [logic control statements](https://github.com/OpenRefine/OpenRefine/wiki/GREL-Controls) (i.e. an **IF** statment.)  Our goal is to create the same timeline facet but with fewer, more complex OpenRefine steps.  You will see in this example that while OpenRefine is a powerful data transformation tool which can easily support casual attention to syntax, file handling, and looping; OpenRefine is also a powerful and extensible tool which supports scripting and begins to look like real programming.  In other words, it's an extensible data transformation tool.

**Goal**: Make the same data transformations as in the previous slide’s steps 2-7, but this time you’ll do it in one step.  Think about how GREL allows you to take shortcuts.


1. <span class="or-menu">issue_date > Edit Column > Add column based on this column…  </span> 
    + New Column Name = `date3`  
    + Expression = `if(value.slice(20,22) == "PM", value.replace(/(.*\s)12(:\d\d:.*)/,"$100$2"), value).toDate()`  
2. Now make a date facet  
    + <span class="or-menu">date3 > Facet > Timeline facet </span> 


## Reproducible

Refine supports reproducible research.  Here are the things you may have already noticed.

* Undo:  every step is recorded and can be undone.
* Share:  your steps are recorded and can be shared in a JSON notation
* projects:  In each OpenRefine "project", all the steps of your project are recorded and are shareable.
* Exporting:  There is a powerful export mechanism that allows you to build selective reports


[^5]: [Dates are Difficult](http://www.i-programmer.info/babbages-bag/391-dates-are-difficult.html) by Mike James (www.i-programmer.info)
