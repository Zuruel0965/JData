items
	parent_type=/obj
	obj1
		icon_state="obj1"
	obj2
		icon_state="obj2"
	obj3
		icon_state="obj3"
	obj4
		icon_state="obj4"
	New()
		suffix="[ref(src)]"//suffix is set to the unique ref of the object
		name="[name]([rand(1000,20000)])"//each item has a randomly generated name
		return ..()

	verb/pickup()
		set src in oview(0)
		Move(usr)
		usr.Data.List_Add("Backpack",src) //Example of using a helper proc to add to a list in the JData
		usr<<"\green You pickup [src]."

	verb/drop()
		set src in usr.contents
		usr<<"\red You drop [src] from your backpack."
		usr.Data.List_Remove("Backpack",src)
		Move(usr.loc)

mob/Player
	verb/Clear_Backpack()//Shows that you can clear out the contents of something
		contents=list()
		src<<"Backpack list cleared."
	verb/LoadBackpack()//And then reload the contents
		contents=Data.Get("Backpack")
		src<<"Backpack list loaded."


mob/Player/verb/create_random_items()
	var/list/l=list()
	for(var/t in typesof(/items))
		l+=t
	l-=/items
	for(var/times=rand(3,10),times>0,times--)
		var/items/I=pick(l)
		I = new I
		I.loc=locate( rand(1,world.maxx), rand(1,world.maxy), rand(1,world.maxz) )
	world<<"<small><b>Random items have been placed around the map for you to pickup."