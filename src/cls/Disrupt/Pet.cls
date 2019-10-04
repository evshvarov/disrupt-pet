Class Disrupt.Pet Extends (%Persistent, %JSON.Adaptor)
{

Property Gender As %VarString;

Property AgeYears As %VarString;

Property Weight As %VarString;

Property Breed As %VarString;

Property AvgActive As %VarString;

Property AvgRest As %VarString;

Property AvgDistance As %VarString;

Property AvgCalories As %VarString;

Property ActivityGoalCurrent As %VarString;

Property SegmentName As %VarString;

Property SegmentAvgActive As %VarString;

Property SegmentAvgRest As %VarString;

Property SegmentGoalsMetPercentage As %VarString;

Property ActivityGoalsMetLifetime As %VarString;

Property DaysGoalsMetLifetime As %VarString;

Parameter Folder = "/iris/app/pet-data/";

Parameter Fields = "Gender,AgeYears,Weight,Breed,AvgActive,AvgRest,AvgDistance,AvgCalories,ActivityGoalCurrent,SegmentName,SegmentAvgActive,SegmentAvgRest,SegmentGoalsMetPercentage,ActivityGoalsMetLifetime,DaysGoalsMetLifetime";

ClassMethod LoadData(file = "Pet-Activity.csv", clear = 1) As %Status
{
    if clear do ..%KillExtent()
    do DISABLE^%SYS.NOJRN
    Set stream=##class(%Stream.FileCharacter).%New()
	set filename = ..#Folder_file
    Set sc=stream.LinkToFile(filename)			
			write filename, !

			Set rec=stream.ReadLine()
            Set rec=stream.ReadLine()

            set fieldlist=$Listfromstring(..#Fields)
			While 'stream.AtEnd 
			{
            	set pet=..%New()
                set fn=0
                set m=##class(%Regex.Matcher).%New("(""[^""]*""|[^,]*),?")
                set m.Text=rec
                while m.Locate() { 
                    if fn=15 Quit  
                    set field=$p(..#Fields,",",$I(fn))
                    set $Property(pet,field)=m.Group(1)
                    //Write !,m.Group(1)
                }
                do pet.%Save()
                //zw pet
                //write !,rec 
                Set rec=stream.ReadLine()				
			}

    do ENABLE^%SYS.NOJRN
}

Storage Default
{
<Data name="PetDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Gender</Value>
</Value>
<Value name="3">
<Value>Age</Value>
</Value>
<Value name="4">
<Value>Weight</Value>
</Value>
<Value name="5">
<Value>Breed</Value>
</Value>
<Value name="6">
<Value>AvgActive</Value>
</Value>
<Value name="7">
<Value>AvgRest</Value>
</Value>
<Value name="8">
<Value>AvgDistance</Value>
</Value>
<Value name="9">
<Value>AvgCalories</Value>
</Value>
<Value name="10">
<Value>ActivityGoalCurrent</Value>
</Value>
<Value name="11">
<Value>SegmentName</Value>
</Value>
<Value name="12">
<Value>SegmentAvgActive</Value>
</Value>
<Value name="13">
<Value>SegmentAvgRest</Value>
</Value>
<Value name="14">
<Value>SegmentGoalsMetPercentage</Value>
</Value>
<Value name="15">
<Value>ActivityGoalsMetLifetime</Value>
</Value>
<Value name="16">
<Value>DaysGoalsMetLifetime</Value>
</Value>
<Value name="17">
<Value>AgeYears</Value>
</Value>
</Data>
<DataLocation>^Disrupt.PetD</DataLocation>
<DefaultData>PetDefaultData</DefaultData>
<IdLocation>^Disrupt.PetD</IdLocation>
<IndexLocation>^Disrupt.PetI</IndexLocation>
<StreamLocation>^Disrupt.PetS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
