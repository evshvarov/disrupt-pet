Class Disrupt.PetREST Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/all" Method="GET" Call="GetAllPets"/>
<Route Url="/:id" Method="GET" Call="GetPet"/>
<Route Url="/:id" Method="PUT" Call="UpdatePet"/>
<Route Url="/:id" Method="DELETE" Call="DeletePet"/>
<Route Url="/" Method="POST" Call="CreatePet"/>
</Routes>
}

ClassMethod GetAllPets() As %Status
{

    #dim tSC As %Status = $$$OK

    Set rset = ##class(Sample.Pet).ExtentFunc()

    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    While rset.%Next() {   
        Set pet = ##class(Sample.Pet).%OpenId(rset.ID)    
        Do pet.%JSONExport()
        Write ","

    }
    Write "]"
    Quit tSC
}

ClassMethod GetPet(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException


    #; Set the response header to plain text
    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set pet = ##class(Disrupt.Pet).%OpenId(id)

    If '$IsObject(pet) {
        Write "Loading data..."
        do ##class(Disrupt.Pet).LoadData()
        Set pet = ##class(Disrupt.Pet).%OpenId(id)
    }
    
    If '$IsObject(pet) Quit ..Http404()

    set json={}
    set json.SegmentGoalsMetPercentage=pet.SegmentGoalsMetPercentage
    do json.%ToJSON()

    Quit tSC
}

ClassMethod CreatePet() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set pet = ##class(Sample.Pet).%New()
    Set data = {}.%FromJSON(%request.Content)


    $$$TOE(tSC,pet.%JSONImport(data))
    $$$TOE(tSC,pet.%Save())

    Set %response.Status = 204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    //d data.%ToJSON()
    Do pet.%JSONExport()

    Quit tSC
}

ClassMethod UpdatePet(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set pet = ##class(Sample.Pet).%OpenId(id)
    If '$IsObject(pet) Return ..Http404()
    Set data = {}.%FromJSON(%request.Content)


    $$$TOE(tSC,pet.%JSONImport(data))
    $$$TOE(tSC,pet.%Save())

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do pet.%JSONExport()

    Quit tSC
}

ClassMethod DeletePet(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set pet = ##class(Sample.Pet).%OpenId(id)
    If '$IsObject(pet) Return ..Http404()

    $$$TOE(tSC,pet.%DeleteId(id))

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

}
