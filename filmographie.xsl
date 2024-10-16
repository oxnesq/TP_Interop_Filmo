<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes" />

    <xsl:template match="/films">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="filmographie.css" />
                <title> filmographie </title>

                <script src="https://code.jquery.com/jquery-2.2.4.min.js"> </script>
                <script src="scroll.js"> </script>
                <link rel="stylesheet" type="text/css" href="scroll.css" />
            </head>
            <body>
                <div id="main">
                    <section>
                        <h1>Filmographie</h1>
                    <br/>
                        <h2>Table des matières des films</h2>
                        <ul>
                            <xsl:apply-templates select="film" mode="tdm">
                                <xsl:sort select="@anneeSortie" order="descending"
                                    data-type="number" />
                                <xsl:sort select="exploitation/nbEntreeSalle" order="descending"
                                    data-type="number" />
                            </xsl:apply-templates>
                        </ul>
                    </section>

                    <section>
                        <h2>Table des matières des acteurs</h2>
                        <ul>
                            <xsl:apply-templates select="acteurDescription" mode="tdm">
                                <xsl:sort select="/nom" order="descending" data-type="number" />
                                <xsl:sort select="/prenom" order="descending" data-type="number" />
                            </xsl:apply-templates>
                        </ul>
                    </section>

                    <section>
                        <h1>Filmographie</h1>
                    </section>
                    <xsl:apply-templates select="film" mode="complet">
                        <xsl:sort select="@anneeSortie" order="descending" data-type="number" />
                        <xsl:sort select="exploitation/nbEntreeSalle" order="descending"
                            data-type="number" />
                    </xsl:apply-templates>

                </div>
                <script>
                    $("#main").onepage_scroll({
                    sectionContainer: "section",
                    easing: "ease",
                    animationTime: 1000,
                    pagination: true,
                    updateURL: false,
                    beforeMove: function(index) {},
                    afterMove: function(index) {},
                    loop: false,
                    keyboard: true,
                    responsiveFallback: false
                    });
                </script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="film" mode="complet" >
        <section>
            <p class="nouveauteType">
                <xsl:if test="@anneeSortie='2015'"> nouveaute </xsl:if>
            </p>
            <img
                src="{image/@ref}" class="film-image" alt="{titre} image" />
                
            <h2>
                <a name="{titre}">
                    <xsl:value-of select="titre" />
                </a>
            </h2>
            <b>
                <xsl:for-each select="genres/genre">
                    <xsl:value-of select="." />, </xsl:for-each>
            </b>
            <br></br>
            <i>film <xsl:value-of
                    select="nationalite" /> de <xsl:value-of select="duree" />min en <xsl:value-of
                    select="@anneeSortie" />
            </i>
            <p>*realise par <xsl:value-of
                    select="realisateur/@prenom" /> <xsl:text> </xsl:text> <xsl:value-of
                    select="realisateur/@nom" />*</p>
            <p>Avec : </p>
            <ul>
                <xsl:for-each select="acteurs/acteur">
                    <li>
                        <xsl:value-of select="." />
                    </li>
                </xsl:for-each>
            </ul>
            <p
                class="histoireType">
                <xsl:apply-templates select="descriptif" />
            </p>

            <br></br>
        </section>
    </xsl:template>

    <xsl:template match="film" mode="tdm">
        <xsl:variable name="position" select="position() + 3" />
        <li>
            <a href="" onclick="event.preventDefault(); $('.main').moveTo({$position});" >
                <!--<xsl:attribute name="href">#<xsl:value-of select="titre" /></xsl:attribute>-->
                <xsl:value-of select="titre" />
            </a> ( <xsl:value-of
                select="count(acteurs/acteur)" /> acteurs ) [ <i>
                <xsl:for-each select="descriptif/keyword">
                    <xsl:value-of select="." />, </xsl:for-each>
            </i>] </li>
    </xsl:template>

    <xsl:template match="acteurDescription" mode="tdm">
        <xsl:variable name="idActeur">
            <xsl:value-of select="@id" />
        </xsl:variable>
    <li>
            <xsl:value-of select="nom" /> <xsl:text> </xsl:text> <xsl:value-of select="prenom" />, <xsl:value-of
                select="dateNaiss" />, (<xsl:value-of
                select="count(//film[acteurs/acteur[@ref=$idActeur]])" /> films) <xsl:text> // films : </xsl:text> 
        <xsl:for-each
                select="//film[acteurs/acteur[@ref = $idActeur]]">
                <xsl:text> </xsl:text> 
            <a>
                    <xsl:attribute name="href">#<xsl:value-of select="titre" /></xsl:attribute>
                    <xsl:value-of select="position()" />
                </a>
            </xsl:for-each>
        </li>
    </xsl:template>

    <xsl:template match="ev">
        <i>
            <xsl:apply-templates />
        </i>
    </xsl:template>

    <xsl:template match="personnage">
        <b>
            <xsl:apply-templates />
        </b>
    </xsl:template>

    <xsl:template match="descriptif">
        <xsl:apply-templates />
    </xsl:template>


</xsl:stylesheet>