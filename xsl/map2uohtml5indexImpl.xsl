<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:df="http://dita2indesign.org/dita/functions"
  xmlns:relpath="http://dita2indesign/functions/relpath"
  xmlns:mapdriven="http://dita4publishers.org/mapdriven"
  xmlns:htmlutil="http://dita4publishers.org/functions/htmlutil"
  xmlns:index-terms="http://dita4publishers.org/index-terms"
  exclude-result-prefixes="xs xd df relpath mapdriven index-terms java xsl mapdriven htmlutil"
  xmlns:java="org.dita.dost.util.ImgUtils"
  version="2.0">

  <xsl:import href="plugin:org.uottawa.bootstrap:xsl/map2bootstrap.xsl"></xsl:import>
  <xsl:param name="fullContentWidth" select="true()" />

 <xsl:template match="/">

   <xsl:message> + [INFO] Generating index page </xsl:message>

    <xsl:apply-templates mode="all-map-processing">
      <xsl:with-param name="rootMapDocUrl" select="document-uri(.)" as="xs:string" tunnel="yes"/>
    </xsl:apply-templates>

  </xsl:template>

  <xsl:template match="/*[df:class(., 'map/map')]" mode="all-map-processing">
    <xsl:param name="rootMapDocUrl" as="xs:string" tunnel="yes"/>

    <xsl:variable name="documentation-title" as="xs:string">
        <xsl:apply-templates select="." mode="generate-root-page-header" />
    </xsl:variable>

    <xsl:variable name="content">
      <div id="employee_group" class="fluid-container">
	      <div class="page-header">
	      	<h1><xsl:call-template name="getString">
              <xsl:with-param name="stringName" select="'employee_group'"/>
            </xsl:call-template></h1>
	      </div>

	      <div class="row">
	        <div id="toolbar" class="col-md-12"></div>
	      </div>

        <xsl:apply-templates select="*" mode="main-nav-root-map-processing"/>
      </div>
    </xsl:variable>

    <xsl:result-document
        href="index.html"
        format="{$xsloutput}"
      >
        <xsl:apply-templates mode="generate-html5-page" select=".">
         <xsl:with-param name="relativePath" select="''" as="xs:string" tunnel="yes"/>
         <xsl:with-param name="content" select="$content" tunnel="yes"/>
         <xsl:with-param name="topic-title" select="$documentation-title" tunnel="yes"/>
         <xsl:with-param name="result-uri" select="'index.html'" tunnel="yes"/>
         <xsl:with-param name="fullContentWidth" select="true()" tunnel="yes"/>
         <xsl:with-param name="withheader" select="false()" tunnel="yes"/>
        </xsl:apply-templates>
      </xsl:result-document>

  </xsl:template>

  <xsl:template match="*[contains(@class, 'mapgroup-d/mapref')]" mode="nav-point-title">
    <xsl:sequence select="./topicmeta/navtitle" />
  </xsl:template>

  <xsl:template match="*[contains(@class, 'map/topicmeta')]" mode="main-nav-root-map-processing">
  	<div class="row">
      <xsl:apply-templates select="*" mode="#current"/>
    </div>
  </xsl:template>

  <xsl:template match="*[contains(@class, 'topic/audience')]" mode="main-nav-root-map-processing">
    <div class="box-container">
		    <a class="group-link" href="{@name}">
			    <div class="box square with-outset with-large-radius">
		            <div id="{@name}" role="button" class="choose-group-button">
			            <h2><xsl:value-of select="@othertype"/></h2>
			            <abbr title="{@othertype}"><xsl:value-of select="upper-case(@name)"/></abbr>
		            </div>
	            </div>
	       </a>
		</div>
  </xsl:template>

  <xsl:template match="*" mode="main-nav-root-map-processing"/>

</xsl:stylesheet>
