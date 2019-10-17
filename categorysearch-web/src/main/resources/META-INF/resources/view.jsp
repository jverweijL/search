<%@ include file="/init.jsp" %>
<!-- Inspired by https://jonmiles.github.io/bootstrap-treeview/ -->

<style type="text/css" id="treeview-checkable-style"> .treeview .list-group-item {
	cursor: pointer
}

.treeview span.indent {
	margin-left: 10px;
	margin-right: 10px
}

.treeview span.icon {
	width: 12px;
	margin-right: 5px
}

.treeview .node-disabled {
	color: silver;
	cursor: not-allowed
}

.node-treeview-checkable {
}

.node-treeview-checkable:not(.node-disabled):hover {
	background-color: #F5F5F5;
} </style>


<c:set var="nodeid" value="-1" scope="request"/>

<div id="treeview-checkable" class="treeview">
	<ul class="list-group">
		<c:forEach items="${vocabulary.getCategories()}" var="category">
			<c:set var="nodeid" value="${nodeid + 1}"  scope="request" />
			<c:if test="${category.isRootCategory()}">
				<li class="list-group-item node-treeview-checkable search-result" data-nodeid="${nodeid}"
					style="color:#D9534F;background-color:undefined;">
					<c:if test="${_AssetCategoryLocalService.getChildCategoriesCount(category.getCategoryId()) > 0}"><span class="icon expand-icon glyphicon glyphicon-minus"></span></c:if>
					<c:if test="${_AssetCategoryLocalService.getChildCategoriesCount(category.getCategoryId()) < 1}"><span class="icon expand-icon glyphicon"></span></c:if>
					<span class="icon check-icon glyphicon glyphicon-unchecked"></span>${category.getName()}
					<span class="badge badge-secondary float-right">
	<span class="badge-item badge-item-expand"><c:if test="${buckets.containsKey(category.getCategoryId())}">${buckets.get(category.getCategoryId())}</c:if></span>
</span>
				</li>
				<c:forEach items="${_AssetCategoryLocalService.getChildCategories(category.getCategoryId())}" var="subcategory">
					<c:set var="nodeid" value="${nodeid + 1}"  scope="request" />
					<li class="list-group-item node-treeview-checkable" data-nodeid="${nodeid}"
						style="color:undefined;background-color:undefined;"><span class="indent"></span>
						<c:if test="${_AssetCategoryLocalService.getChildCategoriesCount(category.getCategoryId()) > 0}"><span class="icon expand-icon glyphicon glyphicon-minus"></span></c:if>
						<c:if test="${_AssetCategoryLocalService.getChildCategoriesCount(category.getCategoryId()) < 1}"><span class="icon expand-icon glyphicon"></span></c:if>
						<span
							class="icon check-icon glyphicon glyphicon-unchecked"></span>${subcategory.getName()}
						<span class="badge badge-secondary float-right">
	<span class="badge-item badge-item-expand"><c:if test="${buckets.containsKey(category.getCategoryId())}">${buckets.get(subcategory.getCategoryId())}</c:if></span>
</span>
					</li>
					<c:forEach items="${_AssetCategoryLocalService.getChildCategories(subcategory.getCategoryId())}" var="subsubcategory">
						<c:set var="nodeid" value="${nodeid + 1}"  scope="request" />
						<li class="list-group-item node-treeview-checkable" data-nodeid="${nodeid}"
							style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="indent"></span><span
								class="icon glyphicon"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>${subsubcategory.getName()}
							<span class="badge badge-secondary float-right">
	<span class="badge-item badge-item-expand"><c:if test="${buckets.containsKey(category.getCategoryId())}">${buckets.get(subsubcategory.getCategoryId())}</c:if></span>
</span>
						</li>
					</c:forEach>
				</c:forEach>
			</c:if>
		</c:forEach>

		<%--<li class="list-group-item node-treeview-checkable search-result" data-nodeid="30"
			style="color:#D9534F;background-color:undefined;"><span
				class="icon expand-icon glyphicon glyphicon-minus"></span><span
				class="icon check-icon glyphicon glyphicon-unchecked"></span>Parent 1
		</li>
		<li class="list-group-item node-treeview-checkable" data-nodeid="31"
			style="color:undefined;background-color:undefined;"><span class="indent"></span><span
				class="icon expand-icon glyphicon glyphicon-minus"></span><span
				class="icon check-icon glyphicon glyphicon-unchecked"></span>Child 1
		</li>
		<li class="list-group-item node-treeview-checkable" data-nodeid="32"
			style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="indent"></span><span
				class="icon glyphicon"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>Grandchild
			1
		</li>
		<li class="list-group-item node-treeview-checkable" data-nodeid="33"
			style="color:undefined;background-color:undefined;"><span class="indent"></span><span class="indent"></span><span
				class="icon glyphicon"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>Grandchild
			2
		</li>
		<li class="list-group-item node-treeview-checkable" data-nodeid="34"
			style="color:undefined;background-color:undefined;"><span class="indent"></span><span
				class="icon glyphicon"></span><span class="icon check-icon glyphicon glyphicon-unchecked"></span>Child 2
		</li>
		<li class="list-group-item node-treeview-checkable" data-nodeid="35"
			style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span
				class="icon check-icon glyphicon glyphicon-unchecked"></span>Parent 2
		</li>
		<li class="list-group-item node-treeview-checkable" data-nodeid="36"
			style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span
				class="icon check-icon glyphicon glyphicon-unchecked"></span>Parent 3
		</li>
		<li class="list-group-item node-treeview-checkable" data-nodeid="37"
			style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span
				class="icon check-icon glyphicon glyphicon-unchecked"></span>Parent 4
		</li>
		<li class="list-group-item node-treeview-checkable" data-nodeid="38"
			style="color:undefined;background-color:undefined;"><span class="icon glyphicon"></span><span
				class="icon check-icon glyphicon glyphicon-unchecked"></span>Parent 5
		</li>--%>
	</ul>
</div>