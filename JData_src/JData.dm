

/*
We are going to give the world and every atom Data storage ability by default
*/
atom/var/Data/Data=new
var/Data/WorldData=new//Needs its own unique identifier so there will be no confusion, since u cant call world.Data you have to access it by WorldData.whatever()



Data
	var
		_Storage[0]

	proc
		Store(_name, _val)
			_Storage["[_name]"]=_val

		Get(_name)
			if(Check(_name))
				.=_Storage["[_name]"]
			else .=null

		Check(_name)
			if(_Storage.Find("[_name]")) .=TRUE
			else .=FALSE

		Remove(_name)
			_Storage-=_name

		//List Helpers

		List_Add(_name,_item)//Adds item to specified list.
			var/list/L=Get(_name)
			if(!islist(L)) L=new/list()
			L+=_item
			Store(_name,L)

		List_Remove(_name,_item)//Remove item from specified list.
			var/list/L=Get(_name)
			if(islist(L))
				if(L.Find(_item)) L-=_item
			Store(_name, L)

		List_Find(_name,_find,start=1,end=0) //Returns The first position of elem in list, or 0 if not found. Passes same functionality as list.Find()
			var/list/L=Get(_name)
			if(islist(L))
				return L.Find(_find,start,end)
			else
				return 0