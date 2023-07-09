world
	name="JData - Demo"
	mob=/mob/Player
	turf=/turf/bg
	icon_size=16

atom/icon='icon.dmi'
turf/bg
	icon_state="bg";name=""

//                                                        _________________________________________________________________________________
mob/verb/check_name(t as text)                           //Can create lists on demand
	var/Data/WD=WorldData                               //Give it a shortcut to make code easier to write.
	if(!WD.List_Find("used_names",t))                  //Check the list to make sure "t" doesnt already exist.
		WD.List_Add("used_names",t)                   //Add it to the used_names list, no worries if one doesnt exist one will be created.
		world<<"[t] added to used_names"             //
	else                                            //
		src<<"This name is already taken."         //




mob/Player
	icon_state="player"
	var/new_player=TRUE
	Login()
		name=ckey
		loc=locate(1,1,1)
		if(new_player==TRUE)
			new_player=FALSE
			//Create initial settings for a player (Example of using JData insted of a variable)
			Data.Store("HEALTH",100)
			Data.Store("MAX_HEALTH",100)
			Data.Store("Power",5)
			Data.Store("Guard",15)
			Data.Store("Class","Wizard")
			Data.Store("Level",1)

		if(WorldData.Check("MOTD")) //Example of displaying world message of the day if set( Its not set by default )
			src<<"\blue Message of the day set to: [WorldData.Get("MOTD")]"
		create_random_items()
		return ..()

	Stat()
		statpanel("Demo - ([name])")
		stat("Health:","[Data.Get("HEALTH")]/[Data.Get("MAX_HEALTH")]")
		stat("Power:",Data.Get("Power"))
		stat("Guard:",Data.Get("Guard"))
		stat("Class:",Data.Get("Class"))
		stat("Level:",Data.Get("Level"))
		stat("DNA",Data.Get("DNA")) //Not defined but doesnt throw an error.
		stat("Items:","")
		stat(contents)
		statpanel("Data Storage")
		for(var/D in Data._Storage) stat(D,Data._Storage[D])
		statpanel("Backpack")
		stat(Data.Get("Backpack"))

		if(WorldData)
			statpanel("World Data")
			var/Data/WD=WorldData
			for(var/D in WD._Storage)
				if(islist(WD._Storage[D]))
					stat("[D]:","")
					var/list/L=WD._Storage[D]
					for(var/C in L) stat(C)
				else
					stat(D,WD._Storage[D])

/*
Examples of using JData
*/
	verb/Change_Name(t as null|text)
		set desc = "Choose a name:"
		Data.Store("Old Name",name)
		name=t
		src<<"\blue Name set to [t]"

	verb/Revert_Name()
		if(Data.Check("Old Name"))
			name=Data.Get("Old Name")
			src<<"\blue name set to [name]"
		else src<<"\red \"Old Name\" not found."

	verb/Save_Name()
		Data.Store("name",name)
		src<<"\blue Name saved."
	verb/Load_Name()
		if(Data.Check("name"))
			name=Data.Get("name")
			src<<"\blue Name loaded - [name]"
		else src<<"\red \"name\" not found."

	verb/Change_MOTD()
		set desc = "Change the servers message of the day."
		var/_msg=""
		var/Data/WD=WorldData
		if(WD.Check("MOTD")) _msg=WD.Get("MOTD")
		var/new_message=input("What do you want the servers message of the day to be?","Change - Message of the Day",_msg)as null|text
		WD.Store("MOTD",new_message)
		world<<"\blue Message of the day set to: [new_message]"


	verb/TakeDamage()
		set category="Combat"
		var/dmg=rand(10,40)
		var/hitpoints=Data.Get("HEALTH")
		hitpoints=clamp(hitpoints-dmg,0,Data.Get("MAX_HEALTH"))
		Data.Store("HEALTH",hitpoints)
		if(hitpoints<=0)
			world<<"\red [name] has died."
			Data.Store("HEALTH",Data.Get("MAX_HEALTH"))
			var/deaths=Data.Get("Deaths")
			deaths++
			Data.Store("Deaths",deaths)
			loc=locate(1,1,1)
			src<<"\green You have died [deaths] times."
		else
			src<<"\red [name] took [dmg] damage."
			src<<"\blue You now have [hitpoints] health left out of [Data.Get("MAX_HEALTH")] max health"

	verb/Levelup()
		set category="Combat"
		var/lvl=Data.Get("Level")
		lvl++
		Data.Store("Level",lvl)
		var/hp_max=Data.Get("MAX_HEALTH")
		hp_max+=25
		var/pow=Data.Get("Power")
		pow+=5
		var/grd=Data.Get("Guard")
		grd+=10
		Data.Store("HEALTH",hp_max)//reset health to max health after level up.
		Data.Store("MAX_HEALTH",hp_max)
		Data.Store("Power",pow)
		Data.Store("Guard",grd)
		world<<"\green <b>[src] has been promoted to level [lvl]!"


//List functionality
	verb/readlist()
		set category="List Functions"
		var/list/L=Data.Get("LIST")
		if(!length(L))
			src<<"\red error: List is empty."
		else
			src<<"--list start--"
			var/count=0
			for(var/a in Data.Get("LIST"))
				count++
				src<<"([count]) = [a]"
			src<<"--list end--"

	verb/generate_test_list()
		set category="List Functions"
		Data.Store("LIST",Random_List())
		src<<"\green Generated Random List"

	verb/list_add(t as text)
		set category="List Functions"
		set desc="What do you want to add?"
		//if(islist(Data_Get("LIST")))
		var/list/L=Data.Get("LIST")
		if(!islist(L)) L=new/list()
		L+=t
		Data.Store("LIST",L)
		src<<"\blue You added \"[t]\" to the list."

	verb/list_remove()
		set category="List Functions"
		var/removal=input("What do you want to remove from the list?","List Removal") in Data.Get("LIST")
		var/list/L=Data.Get("LIST")
		if(islist(L))
			L-=removal
		src<<"\red You removed \"[removal]\" from the list."
		Data.Store("LIST",L)


proc/Random_List()
	var/l=list()
	for(var/c=0,c<=rand(4,20),c++) l+=pick("a[rand(1,10000)]","b[rand(1,10000)]","c[rand(1,10000)]","d[rand(1,10000)]","e[rand(1,10000)]","f[rand(1,10000)]","g[rand(1,10000)]")
	.=l