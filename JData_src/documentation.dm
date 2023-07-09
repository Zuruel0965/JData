/*

   _________      _
  |_  |  _  \    | |
    | | | | |__ _| |_ __ _
    | | | | / _` | __/ _` |
/\__/ / |/ / (_| | || (_| |
\____/|___/ \__,_|\__\__,_|

 ~Version 1.0.0~

 Simple Data Storage for almost anything made easy.

This library adds functionality to make data handling a bit easier.

No credits are required to use this, Its amaizing how 50 lines of code can be so powerful
I had originally created this for one of my projects, but once I saw its potential, I had to share it with everyone.
 Together we will illuminate new paths, conquer challenges, and reshape the world of byond with our shared vision.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Data.Store(_name, _val)

 Adds: "_name" to the Data list with the value of "_val"

 Examples:
           Data.Store("YOUR_NAME",name)



           mob/verb/check_name(t as text) //Can create lists on demand
               if(!WorldData.List_Find("used_names",t))
                   world.WorldData.ListAdd("used_names",t)
                   world<<"[t] added to used_names"
               else
                   src<<"This name is already taken."


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Data.Remove(_name)
 Removes "_name" from the Data list

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Data.Get(_name)

 Returns the value of "_name" set in the data storage
 This can be anything, atom,text,number,client,lists

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Data.Check(_name)

 Returns TRUE or FALSE if "_name" was found in the data storage

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Data.List_Add(_name,_item)

 Same usage as Data.Store() but insted appends the current list if one already exists if not will automatically create one for you

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Data.List_Remove(_name,_item)
 Same usage as Data.Remove() but just removes a item from that current list insted of completly removing the entry.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Data.List_Find(_name,_find,start=1,end=0)

 Same as list.Find() but insted you would just do Data.List.Find(_name,"what_to_find") where "_name" would be the name of the index for the list

 Also won't error out of the list doesnt exist it will insted just return 0

  Returns: The first position of elem in list, or 0 if not found.
   Args:
   Elem:  The element to find.
   Start: The list position in which to begin the search.
   End:   The list position immediately following the end of the search.
      Find the first position of Elem in the list. Elements between Start and End are searched. The default end position of 0 stands for the position immediately after the end of the list, so by default the entire list is searched.


    ~See /demo for more usage on the library~



*/