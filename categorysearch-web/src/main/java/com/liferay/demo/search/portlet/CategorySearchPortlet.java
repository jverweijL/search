package com.liferay.demo.search.portlet;

import com.liferay.asset.kernel.model.AssetVocabulary;
import com.liferay.asset.kernel.service.AssetCategoryLocalService;
import com.liferay.asset.kernel.service.AssetVocabularyLocalService;
import com.liferay.demo.search.constants.CategorySearchPortletKeys;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.liferay.portal.kernel.search.facet.Facet;
import com.liferay.portal.kernel.search.facet.collector.TermCollector;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.Portal;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.search.web.portlet.shared.search.PortletSharedSearchRequest;
import com.liferay.portal.search.web.portlet.shared.search.PortletSharedSearchResponse;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;


/**
 * @author jverweij
 */
@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category=category.search",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=CategorySearch",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + CategorySearchPortletKeys.CATEGORYSEARCH,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class CategorySearchPortlet extends MVCPortlet {

	//TODO make this configurable
	long vocabularyID = 34710;
	final static String CATEGORY_PORTLET_PREFIX = "com_liferay_portal_search_web_category_facet_portlet_CategoryFacetPortlet_INSTANCE_";

	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse) throws IOException, PortletException {


		try {
			// TODO get vocabularyID from config
			AssetVocabulary vocabulary = _AssetVocabularyLocalService.getAssetVocabulary(vocabularyID);
			renderRequest.setAttribute("vocabulary",vocabulary);
			renderRequest.setAttribute("_AssetCategoryLocalService", _AssetCategoryLocalService);

			PortletSharedSearchResponse portletSharedSearchResponse = portletSharedSearchRequest.search(renderRequest);

			HashMap<Long,Integer> buckets = new HashMap();

			ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
			List<String> portletIdList = themeDisplay.getLayoutTypePortlet().getPortletIds();

			for (String portletId: portletIdList) {
				if (portletId.startsWith(CATEGORY_PORTLET_PREFIX)) {
					Facet facet = portletSharedSearchResponse.getFacet(portletId);
					for (TermCollector term : facet.getFacetCollector().getTermCollectors()) {
						buckets.put(Long.parseLong(term.getTerm()), term.getFrequency());
					}
				}
			}
			renderRequest.setAttribute("buckets", buckets);

		} catch (PortalException e) {
			e.printStackTrace();
		}

		super.doView(renderRequest,renderResponse);
	}

	@Reference
	protected AssetVocabularyLocalService _AssetVocabularyLocalService;

	@Reference
	protected AssetCategoryLocalService _AssetCategoryLocalService;

	@Reference
	protected PortletSharedSearchRequest portletSharedSearchRequest;
}