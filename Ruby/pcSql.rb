# encoding: utf-8
require "Mysql"
require 'iconv'

class Msql
  @@conv = Iconv.new("UTF-8", "GBK")
  @@msql = Mysql.init
  @@msql.options(Mysql::SET_CHARSET_NAME, 'utf8') 
  def init(username="root",password="123456",database="dept",filepath="D:\\yueyi\\dept_info.txt")
    @@msql.real_connect("localhost",username,password,database)
    @@msql.query("SET NAMES utf8") 
    @@msql.query("DROP TABLE IF EXISTS info")
    @@msql.query("CREATE TABLE info(id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, child VARCHAR(50),name VARCHAR(1000), parent VARBINARY(50), ZhNet varchar(5000), pcnet varchar(1000)) ENGINE=MyISAM DEFAULT CHARSET=utf8")

    arr||=File.readlines(filepath)
    arr.each_index do |i|
       child = arr[i].split(',')[0]
       name = @@conv.iconv("#{arr[i].split(',')[1]}")
       parent = arr[i].split(',').last.delete("\n")
       @@msql.query("INSERT INTO info (child, name, parent,ZhNet, pcnet) VALUES ("+"'#{child}',"+"'#{name}',"+"'#{parent}',"+"'#{name}',"+"'#{parent}/#{child}')")
    end
  end
    #zpHash["zh","parent"]
  def getZhParentByChild(parent)
    parent =@@msql.query("SELECT parent,name FROM info WHERE child="+"'#{parent}'")
    zpHash = Hash.new 
    parent.each_hash do |h| 
      zpHash["zh"]= "#{h['name']}" 
      zpHash["parent"]= "#{h['parent']}"
    end
    parent.free
    return zpHash
  end
  def createPcHashById(id)
    result = @@msql.query("SELECT child,parent,ZhNet FROM info WHERE id="+"#{id}")
    pcHash = Hash.new
    result.each_hash do |h|
      pcHash["pc"]= "#{h['parent']}/#{h['child']}"
      pcHash["zhnet"]= "#{h['ZhNet']}"
    end
    result.free
    return pcHash
  end
  #pcHash["pc","zhnet"]#zpHash["zh","parent"]
  def getPcHash(pcHash)
    child = "#{pcHash['pc'].split('/')[0]}"
    zpHash = Hash.new
    zpHash = getZhParentByChild(child)
    unless zpHash["parent"].nil?
      pcHash["pc"]= "#{zpHash["parent"]}/#{pcHash['pc']}"
      pcHash["zhnet"]= "#{zpHash["zh"]}/#{pcHash['zhnet']}"
      pcHash["pc"].split("/")[0].length==0? (return pcHash):(return getPcHash(pcHash))
    else
      return pcHash["pc"=>"error","zhnet"=>"false"]
    end
  end
  def updatePcNet
    result = @@msql.query("SELECT * FROM info")
    count = result.num_rows
    result.free
    (1..count).each do |id|
     pcHash = Hash.new
     pcHash = getPcHash(createPcHashById(id))
     unless pcHash.nil?
       pcHash.each_value do |v|
         unless v.nil? then puts "#{v}" end
       end
      insertPcHash(id,pcHash)
     else
       puts "#{id}:is error"
     end
    end
  end
  def insertPcHash(id,pcHash)
    @@msql.query("UPDATE info SET pcnet="+"'#{pcHash['pc']}',ZhNet="+"'#{pcHash['zhnet']}'"+" WHERE id="+"#{id}")
  end
  def close
     @@msql.close if @@msql
  end
end

mysql = Msql.new
mysql.init
mysql.updatePcNet
mysql.close
