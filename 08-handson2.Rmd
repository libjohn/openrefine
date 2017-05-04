# Hands-on: GREL {#grel}

The goal of this project is to create custom facets and perform basic transformations, introduce you to the General Refine Expression Language, and develop practical skills in transforming and normalizing data.  

In this example you  will open a new data set to practice importing a different type of data, this time comma separated value, or CSV.  Last time you imported a tab separated value, or TSV.  OpenRefine will important many types of data.  Being aware of different data formats, and having the ability to open those data are valuable skills.  In fact, one of the most frequently stumbling blocks with data tools is the simple problem of importing the data.  Practice and learn...

## Custom Facets

### Download new Data then Create a new OpenRefine Project: {-}  

We'll use a **subset**[^2] of data from the Raleigh Open Data portal:  “Raleigh Police Incident Data 2005plus2014.csv”.  

1. Open  Data  
    * <span class="or-menu">Create Project  > Web Addresses (URLs) ></span>   `https://github.com/libjohn/openrefine/raw/master/data/Raleigh%20Police%20Incident%20Data%202005plus2014.csv`   
    * <span class="or-menu">Next >></span>  
    * You many want to give your project a pretty title
    * Create Project >>  
2. **Isolate data**: you have incident data without location information  
    - <span class="or-menu">Location > Facet > Customized facets > Facet by blank</span>
    - Click true  (True = cell is blank ; False = cell has data)
    - <ul class="no-bullet">
           <div class="challenge">
           <li>How many matching rows have no location data?</li>
           <p>10,576</p>
           </div>
           </ul>   

> Explanation  
In the step above, you limited your data set to find all the police incident data where there is no location information.  That is, when the cell is blank,there there is no location information.


> Explanation for the next step:
You’ll create a custom facet (by Year) without altering any data.  To do this, you’ll use a very simple expression which takes a slice of data based on fixed position, starting in position 6 (counting begins at 0) and ending four character positions later at 10* (6 + 4=10).  Given the data, find the year value within the “INC DATETIME” field.  


<pre>
DATA:      12/31/2014 11:05:00 PM
Position:  0123  6    1        2
                      1        0
</pre>

> For Example...  
    - To take the year“2014”, use expression: `value[6,10]`[^3]  
    - To take the hour, use `value[11,13]`  
    - To take PM (or AM), use `value[20,22]`  

3. Create a Custom Facet to Sort by Year 
    + <span class="or-menu">INC DATETIME > Facet > Custom text facet ... </span>   
    + Expression = `value[6,10]` <span class="or-menu"> > OK </span>  

<ol start="4">
<li>Sort the facet by Count</li>
<ul>  
<div class="challenge">  
<li>Which year has the most missing data?</li>  
<p>2005</p>  
</div>  
<div class="challenge">  
<li>How many rows match that year?</li>  
<p>10,007 rows with missing location data</p>  
</div>  
<li>Click “**Remove All**” in the Facet/Filter sidebar</li>  
</ul>  
</ol>
    
5. Keep only the data with location values, i.e. delete all rows that have  
no location data...  
    + <span class="or-menu">Location > Facet > Customized facets > Facet by blank </span>   
    + Limit to “**true**”  
    + <span class="or-menu">All > Edit rows > Remove all matching rows </span>   
    + Close (“X out”) the facets  

## GREL to Transform and Normalize 

The [General Refine Expression Language](https://github.com/OpenRefine/OpenRefine/wiki/General-Refine-Expression-Language) (GREL) is a powerful and extensible language to manipulate data.  In these next steps we will learn GREL by using practical steps to improve the structure of the data.  

6. **Split** the LOCATION Column into two columns (Latitude and Longitude)  
    + <span class="or-menu">LOCATION > Edit column > Split into several columns… > OK </span>   (i.e. Accept the defaults)  
    + Rename Columns  
        + <span class="or-menu">Location 1 > Edit column > Rename this column > `Latitude` </span>     
        + <span class="or-menu">Location 2 > Edit column > Rename this column > `Longitude` </span>   
    + Remove parenthesis and trim whitespace  
        + <span class="or-menu">Latitude > Edit cells > Transform ... </span>  
            1. Expression = `value.replace("(","")` <span class="or-menu">> OK </span>   
            2. <span class="or-menu">Latitude > Edit cells > Common transformations > Trim leading and trailing whitespace </span>   
        + <span class="or-menu">Longitude > Edit cells > Transform ... </span>   
            1. Expression = `value.replace(")","")` <span class="or-menu">> OK </span>   
            2. <span class="or-menu">Longitude > Edit cells > Common transformations > Trim leading and trailing whitespace </span>   

### Regular Expression {-}  

Regular Expressions are very powerful and flexible codes used for matching patterns.  Often there is more than one way to compose a regex pattern-match.  Importantly for OpenRefine, much of Refine's extensible and advanced power comes from regular expressions.  Essentially the key to advanced level OpenRefine is regular expressions and looping.  To learn more about regular expressions see my [handout on regex](http://libjohn.github.io/regex/regex.html).  For now you can refer to these **few commands** and symbols summed up on this [quick-sheet](http://libjohn.github.io/regex/cheat-sheet.html).

7.  Create New Column from Existing Column using a regular expression to match a pattern  
    + <span class="or-menu">INC DATETIME > Edit column > Add column based on this column ... </span>   
        1. New column name = `YEAR`  
        2. Expression = `value.match(/.*\/(\d{4}).*/)[0]` > <span class="or-menu">OK</span>[^4]
        
### Filter  {-}  
8. Create a Text Filter:  Explore your data to find how many incident descriptions involve bicycles  
<ol type="1">
<li><span class="or-menu">LCR DESC >Text filter </span></li>
<li>In the filter box, enter the term `bicycle`</li>
<div class="challenge"> 
<li>How many matching rows of data use the word "bicycle" in the description?</li>
<p>251</p>
</div>
</ol> 

### Facet  {-}  

<ol start="9">
<li>Make a Text Facet on the LCR DESC column</li>
<ol>
<li><span class="or-menu">LCR DESC > Facet > Text facet</span></li>  
<div class="challenge">  
<li>How many Bicycle categories exist in the facet window?</li>  
<p>6</p>  
</div>
<div class="challenge">  
<li>Which facet is most often used “LCR DESC” facet?</li>  
<p>LARCENY/BICYCLES ($50-$199) - 119</p>  
</div>
</ol>
</ol>


### Cluster  {-}  

10. Look for Cluster variations in the FELONY Column  
    + [Clustering](https://github.com/OpenRefine/OpenRefine/wiki/Clustering-In-Depth) refers to the operation of finding groups of different values that might be alternative representations of the same thing.  For example “Gödel" and "Godel".  This is a handy way to find spelling variations.  
    + <span class="or-menu">FELONY > Facet > Text facet </span>   
    + <span class="or-menu">FELONY > Edit cells > Cluster and edit … </span>  
        + Method = “key collision” ; Key Function = “metaphone3”  
    + For each row, check “Merge?” and change the “New Cell Value” 
        i. to `Felony` in the first row  
        i. to `Not Felony` in the second row  
        i. click the "Merge Selected & Re-Cluster" button    
        i. Try other "Methods" and "Keying Functions".  "Merge Selected & Re-Cluster" after each operation  
        i. Close
        i. <ul class="no-bullet">
           <div class="challenge">
           <li>How many “Not Felony” bicycle larcenies were recorded?</li>
           <p>There are 234 “Not Felony” items after clustering using both “key collision” and “nearest neighbor” methods of clustering</p>
           </div>
           </ul>         
        

        
### Mass Editing {-}  
11. Mass Edit cells in LCR DESC Facet: <span class="or-menu">LCR DESC > Facet > Text facet</span>
    + Mouseover & Edit “LARCENY/BICYCLE/FELONY/$200- …”  
    + delete “/FELONY” 
    + Add an “S” to ‘BICYCLE’ > Apply 
12. <ul class="no-bullet">
     <div class="challenge">
     <li>How many rows match the "LARCENY/BICYCLES ($200-$1000)" Category</li>
     <p>There are 115 observatins (or rows) matching “LARCENY/BICYCLES ($200-$1,000)” category</p>
     </div>
     </ul>
13. Export as an Excel File  
    + <span class="or-menu">Export > Excel </span>   

<!-- special thanks to the folks at software carpentry.  I riffed from their
workshop template to create the Q&A javacript/style.  See https://github.com/swcarpentry/workshop-template -->
<script src="assets/js/qa.js"></script>


[^2]:  Original Data Source:  [Raleigh Open Data](https://data.raleighnc.gov/)
[^3]: You may notice what seems to be either a math or logic error in how this second value is “counted.” The simple explanation is the first number counts from zero.  Add to that number the string length counting from 1 to get the second value.   
[^4]:  Here’s another GREL example that captures the same data:  `value.match(/(\d\d)\/\d{2}\/(\d{4})\s.*\s([A|P][M])/)[1]`
