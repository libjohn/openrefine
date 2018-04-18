# Demonstration {-}

## Load Data {-}
    
1. <span class="or-menu">Create Project  > Web Addresses (URLs) > </span> `https://raw.githubusercontent.com/libjohn/openrefine/master/data/bicycle-subset-phm-collection.tsv`
2. Uncheck - "Quotation marks are used to enclose" (bottom-right)
3. Project Name to "bicycle categories"

## Navigating the "Project" {-}
* Notice there are 72 rows  
* Notice there are two views: rows and records   
* The “records” view is for advanced manipulation
* You can
    + “Show” 5-50 rows at a time
    + Navigate screens “< Previous” & “next >” 

## Facets  {-}
* <span class="or-menu">Categories > Facet > Text facet</span>
    1. Notice mashup of “pipe delimited” text facets
    2. *Why are there Pipe delimiters?*
    3. *How many Category choices exist?*
    4. Switch between the “name” and “count” sorting options. 
* Export a CSV file
* <span class="or-menu">Export > Comma-separated value</span>
* *How many rows will export:  4, 16, 72, 180?*  

## Rows vs. Records {-}

* Row v Records ^[Row v Records [Explained](http://kb.refinepro.com/2012/03/difference-between-record-and-row.html)]  

* <span class="or-menu">Categories > edit cells > split multi-valued cells ></span> separator = ` | `  
    1. *Now how many Category choices exist?*
    2. Click **records** to switch to the records view
    3. Click **count**  What is the most popular Category term?
    4. Click **name**  Limit to the “Juvenilia” facet; How many matching records?

## Web Scrape & API  {-}
*Scraping data from an API or Webpage*

* <span class="or-menu">new_link > Edit column > Add column by fetching URLs…</span>
* New column name = ` Web Data `
* *Notice* Throttle delay  
    1. `2000` milliseconds is good. 
    Less than 2 seconds and you *might* get booted, blocked, cast out!
* Click OK and wait 
* When done, you’ve got all the source data for each page associated with the link in the “Persistent Link” column

## Parsing Data {-}
A Brief Introduction  

* Look fora big block of gobbly text in the “Web Data” column.  That is HTML formatted data  
* Typically, after fetching data, you’ll need to parse it  
* You can use GREL ^[[General Refine Expression Language](https://github.com/OpenRefine/OpenRefine/wiki/General-Refine-Expression-Language)] to parse data and isolate a specific bit of desired information
    * **GREL** is the advanced power of OpenRefine. [We will come back to this](#grel)
* For example, you can transform the data in the retrieved cells with a [regular expression](https://github.com/libjohn/guides/blob/master/regex/regex.Rmd) to gather only the title of each object  
* <span class="or-menu">Web Data > Edit column > Add column based on this column...</span>
    1.  New Column Name = ` Web Page Title `
    2. Expression = ` value.parseHtml().select("h1.object-page__title")[0].htmlText() `


## Split   {-}
* remove faceting:  click <span class="or-menu">Remove All</span> in the facet sidebar

* <span class="or-menu"> Production Date > Edit column > Split into several columns...</span>
    1. Seperator = ` - `  (i.e. "space dash space")

## Concatenate {-}  
* <span class="or-menu">Height > Edit column > Add column based on this column</span>
* GREL Expression = `value + " x " + cells["Width"].value`

## Find & Replace {-}
* <span class="or-menu">Dimension > Edit cells > Transform</span>
* GREL Expression = `value.replace("mm","")`

## Facet by Blank {-}
* <span class="or-menu">Dimension > Facet > Customized facet > facet by blank</span>


## Text filter {-}
* Clear all facets
* Title = `bmx`

## Custom Facet {-}
* Production date
* <span class="or-menu">Facet > custom text facet</span>
* `value.match(/(\d\d).*/)[0]`
