###database
def insert_woeids_place_all_info_to_db(google_trend_final_list, country)
		#insert google hot data into the data; also have to clean it up a little
		woeids = google_trend_final_list
		insertst_orig =  'insert into tubes_trends.google_hottrends ( woeid , the_date, sdoid , title, 
			search_count, rank, url, image_url) VALUES '
		begin
			db = MyCoolClass.new
			#connect to sql db
			mydb =  db.connect_to_sqldb
			woeids.each do |w|
				#transform certain woeids to sql strings, so you won't have insert problems
				##strings in array that need to be transformed are: [3,4, 13, 15, 16, 17, 18, 19, 20]
				insertst = insertst_orig + " ( "
				mystringnumbs = [3, 6, 7]
				mystringnumbs.each do |i| 
					ststf = w[i] 
					if ! ststf.nil?
						ststf = mysanitize(ststf)
						w[i] = "'" + ststf + "'"
					end
				end
				w.each do |w2|
					###make sure to escape all the weird chars; Don't want a sql injection atttack on the db
					if w2.nil?
						w2 = " '',"
						insertst = insertst + w2 
					else
						insertst = insertst + w2 + ","
					end
				end
				insertst = insertst.chop + "); "
			mydb.query(insertst)
			end 
		rescue Exception=>e 
			puts insertst
			puts "Something went wrong! Trying to insert this country: " + country + "but it didn't work"
			puts e
		end
	end
#insert_woeids_place_all_info_to_db(google_trend_list, country)