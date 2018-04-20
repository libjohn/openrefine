# Hands On: Reconciliation

OpenRefine's *[Reconciliation](https://github.com/OpenRefine/OpenRefine/wiki/Reconciliation)* service is used to semi-automate the process of matching data in OpenRefine fields with more authoritative data in external sources.  This reconciliation function is called **semi**-automated because the end-user is given the opportunity to interactively approve or select which data are modified by choosing from a pick-list of results. This process can be used to improve and standardize individual data fields or columns of data inside of OpenRefine.  Or it can be used to extend the data in OpenRefine.

> For example:  Match each name in a list of authors against an external authoritative list of authors. Augment the authoritative entry of each author's name; Add an example book title for each author.


## Reconciliation

**Goal**: Import [new author data](https://github.com/libjohn/openrefine/blob/master/data/AA-authors-you-should-read.csv) into a new project, Use the WikiData and VIAF reconciliation services to gather authoritative versions of African American author names and an example of each author's work, plus their placed of birth and death.

<div class="video"> 
<iframe width="560" height="315" src="https://www.youtube.com/embed/ugZaMCsvg90" frameborder="0" 
allowfullscreen></iframe>
</div>



1. Make a New Project, Import Author Data 

    - <span class="or-menu">Create Project  > Web Addresses (URLs) ></span> ` https://raw.githubusercontent.com/libjohn/openrefine/master/data/AA-authors-you-should-read.csv `
    - <span class="or-menu">Next >></span>  
    - You many want to give your project a pretty title
    - <span class="or-menu"> Create Project >> </span>

1. <span class="or-menu"> author > Reconcile > Start reconciling... </span>

    a. Change the **Show:** to **25**  so you can see all 11 records.

    a. First time / One time ...
    
        i. <span class="or-menu"> Add Standard Service... </span>
        i. In the **Enter the service's URL:** textbox, enter:  ` http://refine.codefork.com/reconcile/viaf `^[http://refine.codefork.com/]
        i.  Name = "Reconciled Authors"
        i. click **VIAF**
        i. Under *Reconcile each cell to an entity of one of these types:*, choose **Work**
        i. Click, <span class="or-menu">Start Reconciling</span>
        i. <span class="or-menu">authors > Reconcile > Actions > Match each cell to its best candidate</span>
        i. <span class="or-menu">authors > Edit column > Add column based on this column... </span>
        
            a. New column name = **major works**
            b. Expression = `cell.recon.candidates[0].name`   ^[http://liwong.blogspot.com/2017/07/tutorial-on-objects-and-cellrecon-object.html]
            c. <span class="or-menu"> OK </span>
        
    b. The rest of the time...
    
        i. <span class="or-menu"> author > Reconcile > Start reconciling... </span>
        i. Under **Services**, click **Wikidata Reconciliation for OpenRefine (en)**
        i. Under *Reconcile each cell to an entity of one of these types:*, choose, **human**
        i. Click, <span class="or-menu">Start Reconciling</span>
        i. In the left-hand sidebar,  <span class="or-menu">Remove All</span> facets
        i. By clicking the approriate single checkbox in each cell of the *authors* column, **manually** slect the most appropriate author for our topic.  (Our topic is African American Authors everyone should read).  Not every cell has an author for which you must make a selection.  Cells 2, 10 need your intervention. 
        
            a. In Cell 2, James Baldwin, select the first option which a match of "(100)"
            a. In cell 10, Click on the first name, then the second name.  Do you see an African-American writer?  Choose him by clicking the corresponding single check-mark
            
2.  Add more metadata from Wiki Data  (only works for Wikidata as of this writing)

    a. <span class="or-menu">authors > Edit column > Add columns from reconciled values...</span>
    a. Under **Suggested Properties**, click *place of birth* and *place of death*
    a. <span class="or-menu">OK</span>
    
3.  Copy the author and dates information from the 'Richard Wright' cell under the "major works" column; **Edit** the Richard Write cell under the "authors" column ; paste in the more complete information:  `Wright, Richard, 1908-1960`
    
3. Add authoritative author data from VIAF

    a. <span class="or-menu"> author > Reconcile > Start reconciling... </span>
    a. Under *Reconcile each cell to an entity of one of these types:*, choose **Person**
    a. Click, <span class="or-menu">Start Reconciling</span>
    a. <span class="or-menu">authors > Reconcile > Actions > Match each cell to its best candidate</span>
    a. By useing the *Choose new match* option, fix row 2.
    
4. Transform the "major works" column by splitting the column at the pipe:  `|'
        
3. Can Export as CSV (Excel, etc.) with Reconciled info.


## Reconciliation Resources

- YouTube: [Reconcilliation in OpenRefine: Part 1](https://www.youtube.com/watch?v=q8ffvdeyuNQ) by Owen Stephens
- YouTube: [Reconcilliation in OpenRefine part 2](https://www.youtube.com/watch?v=0tQPmfb6IFk)
- [Reconciliation Data Sources](https://github.com/OpenRefine/OpenRefine/wiki/Reconcilable-Data-Sources)
- For low use needs:  [VIAF / ORCID / Open Library](http://refine.codefork.com/)
- For more advanced needs:  [conciliator](https://github.com/codeforkjeff/conciliator#conciliator)
- [OpenRefine documentation on Reconciliation](https://github.com/OpenRefine/OpenRefine/wiki/Reconciliation)
- [OpenRefine technical documentation on reconciliation API](https://github.com/OpenRefine/OpenRefine/wiki/Reconciliation-Service-API)
- Transform Recon Candidates to cell data: [e.g. cell.recon.candidates[0].id](http://liwong.blogspot.com/2017/07/tutorial-on-objects-and-cellrecon-object.html)

