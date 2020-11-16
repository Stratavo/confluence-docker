<%@ page import="com.atlassian.confluence.user.AuthenticatedUserThreadLocal" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.okta.saml.util.HttpUtil" %>
<%
    String relayState = request.getParameter("RelayState");
    if (StringUtils.isBlank(relayState) || HttpUtil.isInvalidRelayStateUrl(relayState, request)) {
        relayState = request.getContextPath();
    }
    if (AuthenticatedUserThreadLocal.get() != null) {
        response.sendRedirect(response.encodeRedirectURL(relayState));
    } else {
        String loginUrl = request.getContextPath() + "/login.action?os_destination=" + relayState;
        response.sendRedirect(response.encodeRedirectURL(loginUrl));
    }
%>
