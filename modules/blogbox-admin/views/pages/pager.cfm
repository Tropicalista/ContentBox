<cfoutput>
<div id="pagerPages">
<!--- Loader --->
<div class="loaders floatRight" id="pagePagerLoader">
	<img src="#prc.bbRoot#/includes/images/ajax-loader-blue.gif" alt="loader"/>
</div>
<!--- Paging --->
<cfif prc.pagePager_pagination>
	#prc.pagePager_pagingPlugin.renderit(prc.pager_pagesCount,prc.pagePager_pagingLink)#
</cfif>

<!--- entries --->
<table name="entries_pager" id="entries_pager" class="tablelisting" width="100%">
	<thead>
		<tr>
			<th>Page Info</th>	
			<th>Author</th>
			<th width="125">Dates</th>
			<th width="40" class="center"><img src="#prc.bbRoot#/includes/images/sort.png" alt="sort" title="Page Order"/></th>
			<th width="40" class="center"><img src="#prc.bbRoot#/includes/images/publish.png" alt="publish" title="Published"/></th>
			<th width="40" class="center"><img src="#prc.bbRoot#/includes/images/glasses.png" alt="views" title="Number of Views"/></th>
			<th width="40" class="center"><img src="#prc.bbRoot#/includes/images/comments.png" alt="comments" title="Number of Comments"/></th>
			<th width="75" class="center">Actions</th>
		</tr>
	</thead>
	
	<tbody>
		<cfloop array="#prc.pager_pages#" index="page">
		<tr data-pageID="#page.getPageID()#">
			<td>
				<!--- Title --->
				<a href="#event.buildLink(prc.xehPageEditor)#/pageID/#page.getPageID()#" title="Edit Page">#page.getTitle()#</a><br>
				<!--- Recursive Slug --->
				<strong>Layout: </strong> #page.getLayout()#<br/>
				<strong>Hierarchy: </strong> #page.getRecursiveSlug()#<br/>
				<!--- password protect --->
				<cfif page.isPasswordProtected()>
					<img src="#prc.bbRoot#/includes/images/lock.png" alt="locked" title="Page is password protected"/>
				<cfelse>
					<img src="#prc.bbRoot#/includes/images/lock_off.png" alt="locked" title="Page is public"/>
				</cfif>
				&nbsp;
				<!--- comments icon --->
				<cfif page.getallowComments()>
					<img src="#prc.bbRoot#/includes/images/comments.png" alt="locked" title="Commenting is Open!"/>
				<cfelse>
					<img src="#prc.bbRoot#/includes/images/comments_off.png" alt="locked" title="Commenting is Closed!"/>
				</cfif>			
			</td>
			<td>#page.getAuthorName()#</td>
			<td>
				<strong title="Published Date">P:</strong> #page.getDisplayPublishedDate()#<br/>
				<strong title="Created Date">C:</strong> #page.getDisplayCreatedDate()#
			</td>
			<td class="center">#page.getOrder()#</td>
			<td class="center">
				<cfif page.getIsPublished()>
					<img src="#prc.bbRoot#/includes/images/button_ok.png" alt="published" title="Entry Published!" />
					<span class="hidden">published</span>
				<cfelse>
					<img src="#prc.bbRoot#/includes/images/button_cancel.png" alt="draft" title="Entry Draft!" />
					<span class="hidden">draft</span>
				</cfif>
			</td>
			<td class="center">#page.getHits()#</td>
			<td class="center">#page.getNumberOfComments()#</td>
			<td class="center">
				<!--- Edit Command --->
				<a href="#event.buildLink(prc.xehPageEditor)#/pageID/#page.getPageID()#" title="Edit #page.getTitle()#"><img src="#prc.bbroot#/includes/images/edit.png" alt="edit" border="0"/></a>
				&nbsp;
				<!--- Create Child --->
				<a href="#event.buildLink(prc.xehPageEditor)#/parentID/#page.getPageID()#" title="Create Child Page"><img src="#prc.bbroot#/includes/images/parent.png" alt="edit" border="0"/></a>
				&nbsp;
				<!--- View in Site --->
				<a href="#prc.bbHelper.linkPage(page)#" title="View Page In Site" target="_blank"><img src="#prc.bbroot#/includes/images/eye.png" alt="edit" border="0"/></a>
			</td>
		</tr>
		</cfloop>
	</tbody>
</table>
<!--- Custom JS --->
<script type="text/javascript">
$(document).ready(function() {
	$("tr:even").addClass("even");
	// quick look
	$("##entries_pager").find("tr").mousedown(function(e) {
	    if (e.which === 3) {
	    	if( $(this).attr('data-pageID') != null ){
				openRemoteModal('#event.buildLink(prc.xehPageQuickLook)#/pageID/' + $(this).attr('data-pageID'));
				e.preventDefault();
			}
	    }
	});
});
function pagerLink(page){
	$("##pagePagerLoader").fadeIn("fast");
	$('##pagerPages')
		.load('#event.buildLink(prc.xehPagePager)#/pager_authorID/#prc.pagePager_authorID#/pager_parentID/#prc.pagePager_parentID#/page/' + page, function() {
			$("##pagePagerLoader").fadeOut();
			activateTooltips();
	});
}
</script>
</div>
</cfoutput>