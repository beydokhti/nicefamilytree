package nicefamilytree
/**
 * Member service
 * 
 * @author Manohar Viswanathan
 */
class MemberService {
	
    boolean transactional = true
    
    // get member
    def get(id) {       
       return id? FamilyMember.get(id) : null
    }
    
    // clear avatar image
    def resetAvatar(id) {
    	def member = get(id)
    	member.avatar = null
    	member.avatarMime = null
    	member.save()

        //todo-mtb delete small avatar from tempAvatar
    }
    
    // create a new member
    def createFamilyMember(member, wedding) {
       log.debug "IN FamilyMemberService::createFamilyMember"
       member.save()
       if (wedding) wedding.save()
       log.debug "OUT FamilyMemberService::createFamilyMember"
       return member
    } 
    
    // update family member
    def updateFamilyMember(member) {
       log.debug "IN MemberService::updateFamilyMember"
       def existingFamilyMember = get(member?.id)
       if (existingFamilyMember) {
         existingFamilyMember.nickname = member.nickname
         existingFamilyMember.name = member.name
         existingFamilyMember.birthDate = member.birthDate
         existingFamilyMember.deathDate = member.deathDate
         existingFamilyMember.gender = member.gender
         if (member.avatarMime) {
        	 existingFamilyMember.avatar = member.avatar
             existingFamilyMember.avatarMime = member.avatarMime         	
         }
         existingFamilyMember.root = member.root
         existingFamilyMember.parent = member.parent                  
         existingFamilyMember.save()
       }
       log.debug "OUT MemberService::updateFamilyMember"
       return existingFamilyMember
    }
    
    // delete family member
    def deleteFamilyMember(id) {
       log.debug "IN MemberService::deleteFamilyMember"
       def result
       def member = get(id)
       if (member && !member.children && !member.root) {
    	  // delete all wedding for this member
    	  member.weddings.each { wedding-> wedding.delete() }
          member.delete()
          result = true
       }
       log.debug "OUT MemberService::deleteFamilyMember"
       return result
    }
    
    // get family root
    def getRootMember() {
    	FamilyMember.findByRoot(true)	
    }
    
    // list eligible spouses
    def listEligibleSpouses(member, active) {
      def filteredResults
      def eligibleGender = member.gender=="MALE"? "FEMALE" : "MALE"
      def c = FamilyMember.createCriteria()
      def results = c { 
         eq("gender", eligibleGender)
         order("nickname", "asc")
      }
      if (active) {
         filteredResults = results.findAll { it.wedding==null }
         if (member.spouse) filteredResults << member.spouse 
      } else {
    	   filteredResults = results
      }
      return filteredResults
    }
    
    // list eligible parents
    def listEligibleParents(member) {
    	def eligibleParentList
    	if (member && member.birthDate) {
    		eligibleParentList = Wedding.executeQuery("select w from Wedding w")
    	} else {
            eligibleParentList = Wedding.list()
    	}
    	return eligibleParentList
    }
    
    // get # male, female
    def getGenderCount() {
    	def male = FamilyMember.executeQuery("select count(fm) from FamilyMember fm where fm.gender='MALE'").get(0)
    	def female = FamilyMember.executeQuery("select count(fm) from FamilyMember fm where fm.gender='FEMALE'").get(0)
    	[male, female]
    }
    
    // get # in each age group
    def getAgeCount() {
    	def group80 = FamilyMember.executeQuery("select count(fm) from FamilyMember fm where fm.deathDate is null and fm.birthDate <= :time", [time:moveDate(-80)]).get(0)
    	def group60_80 = FamilyMember.executeQuery("select count(fm) from FamilyMember fm where fm.deathDate is null and fm.birthDate <= :time1 and fm.birthDate > :time2", [time1:moveDate(-60), time2:moveDate(-80)]).get(0)
    	def group40_60 = FamilyMember.executeQuery("select count(fm) from FamilyMember fm where fm.deathDate is null and fm.birthDate <= :time1 and fm.birthDate > :time2", [time1:moveDate(-40), time2:moveDate(-60)]).get(0)
    	def group20_40 = FamilyMember.executeQuery("select count(fm) from FamilyMember fm where fm.deathDate is null and fm.birthDate <= :time1 and fm.birthDate > :time2", [time1:moveDate(-20), time2:moveDate(-40)]).get(0)
    	def group0_20 = FamilyMember.executeQuery("select count(fm) from FamilyMember fm where fm.deathDate is null and fm.birthDate <= :time1 and fm.birthDate > :time2", [time1:moveDate(-0), time2:moveDate(-20)]).get(0)
    	def groupDead = FamilyMember.executeQuery("select count(fm) from FamilyMember fm where fm.deathDate is not null").get(0)
    	[ groupDead, group0_20, group20_40, group40_60, group60_80, group80 ]
    }
    
    // utility method
    private moveDate(years) {
    	def today = Calendar.getInstance()
    	today.add(Calendar.YEAR, years)
    	today.time
    }
}