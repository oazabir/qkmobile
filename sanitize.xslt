<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#160;"> ]>
<xsl:stylesheet version="1.0" 
  xmlns:xhtml="http://www.w3.org/1999/xhtml" 
  xmlns="http://www.w3.org/1999/xhtml" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs xml xhtml"
  >
  
	<xsl:output method="xml" version="4.0" indent="yes" disable-output-escaping="yes" encoding="UTF8" omit-xml-declaration="yes"/>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="comment()"/>

	<xsl:template match="script|style|meta|footer|div[@id='fb-root']|link|div[@class='awac-wrapper']|div[@class='printfriendly']|div[@id='comments']|div[@id='widget-area']|div[@class='post-thumbnail']|hr">
	</xsl:template>
	
	<xsl:template match="button[@class='secondary-toggle']">
		<a href="../index/index.html">
			<button class="secondary-toggle">Menu and widgets</button>
		</a>
	</xsl:template>
	
	<!--<xsl:template match="a[@href='../index.html']">
		<xsl:attribute name="href">
			<xsl:text>../index/index.html</xsl:text>
		</xsl:attribute>
	</xsl:template>-->
	
	<xsl:template match="p//*[contains(.,'পড়ো —')]">
	</xsl:template>
	<xsl:template match="p//*[contains(.,'বই কিনুন')]">
	</xsl:template>
	<xsl:template match="p//*[contains(.,'ডাউনলোড করুন')]">
	</xsl:template>
	
	<xsl:template match="a[@href='http://quranerkotha.com/wp-content/uploads/2016/10/Poro-POD.pdf']">
	</xsl:template>
	
	<xsl:template match="a[@href='https://play.google.com/store/apps/details?id=com.quranerkotha.app']">
	</xsl:template>
 
	<xsl:template match="a/@href[contains(.,'/')]">
		<xsl:attribute name="href">
			<xsl:variable name="href" select="." />		
			<xsl:variable name="output">
				<xsl:choose>
					<xsl:when test="starts-with($href,'https://quranerkotha.com/')">
						<xsl:value-of select="concat('../', substring-after($href,'https://quranerkotha.com/'))" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$href" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="length" select="string-length($output)"/>    
			<xsl:variable name="output2">
				<xsl:choose>
					<xsl:when test="substring($output,$length) = '/'">
						<xsl:value-of select="concat($output, 'index.html')" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$output" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>		
			<xsl:value-of select="$output2" />
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="img/@src[starts-with(.,'https://quranerkotha.com/')]">
		<xsl:attribute name="src">
			<xsl:value-of select="concat('../', substring-after(.,'https://quranerkotha.com/'))"/>
		</xsl:attribute>		
	</xsl:template>
	
	<xsl:template match="img/@srcset">
		<xsl:attribute name="srcset">
			<xsl:text></xsl:text>
		</xsl:attribute>		
	</xsl:template>
	
	<xsl:template match="img/@src[starts-with(.,'http://quranerkotha.com/')]">
		<xsl:attribute name="src">
			<xsl:value-of select="concat('../', substring-after(.,'http://quranerkotha.com/'))"/>
		</xsl:attribute>
	</xsl:template>
	 
	<xsl:template match="head">
		<head>
			<title>কুর‘আনের কথা</title>
		
			<link rel="stylesheet" id="parent-style-css" href="../wp-content/themes/twentyfifteen/style.css" type="text/css" media="all" />
			<link rel="stylesheet" id="twentyfifteen-style-css" href="../wp-content/themes/2015-child-right-sidebar/style.css" type="text/css" media="all" />
			<link rel="stylesheet" id="genericons-css" href="../wp-content/themes/twentyfifteen/genericons/genericons.css" type="text/css" media="all" />
		
		</head>
	</xsl:template>
	<xsl:template match="link[id='twentyfifteen-style-css']" >
		<link rel="stylesheet" id="twentyfifteen-style-css" href="../wp-content/themes/2015-child-right-sidebar/style.css?ver=20130711" type="text/css" media="all" />
	</xsl:template>

</xsl:stylesheet>
