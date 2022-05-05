class SlvcGenerator 
    #an slvc is a two page report:
        #page one is a short table with count of stores organized by location
        #page two is the store list with ALL SLvC data appended to the end
        #should export as a formatted excel file

    def self.test 
        puts "test"
    end

    def self.slvc_data_update(file)
        h = CSV.read(file)
        i = 1
        h.each do |row|
            n = Slvcdata.new(
                zip: row[0],
                company: row[1],
                market: row[2],
                wrap: row[3],
                hh_count: row[4],
                newspaper: row[5],
                highest_circulation: row[6],
                newspaper_penetration: row[7],
                county: row[8],
                county_code: row[9],
                dma_num: row[10],
                dma_name: row[11],
                frequency: row[12],
                ihd:row[13]
            )
            n.save
            puts "finished: #{i+=1}"
        end
    end
end