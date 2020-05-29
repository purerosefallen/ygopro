--高速决斗技能-陷阱分堆
Duel.LoadScript("speed_duel_common.lua")
function c100730035.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730035.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730035.filter(c,g)
	if not c:IsType(TYPE_TRAP) then return false end
	local tc=g:GetFirst()
	while tc do
		if c:GetOriginalCode()==tc:GetOriginalCode() then
			return false
		end
		tc=g:GetNext()
	end
	g:AddCard(c)
	return true
end
function c100730035.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730035.filter,tp,LOCATION_DECK+LOCATION_HAND,0,4,nil,g) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730035,0))
		e:Reset()
		return
	end
	g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	local count=aux.SpeedDuelSendToDeckWithExile(tp,g)
	local gA=Group.CreateGroup()
	local gB=Group.CreateGroup()
	local gDeck=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_DECK,0,nil)
	gA=gDeck:RandomSelect(tp,2)
	gDeck:Sub(gA)
	gB=gDeck:RandomSelect(tp,4)
	gDeck:Sub(gB)
	local gBFinal=Group.CreateGroup()
	if (not gA:IsExists(Card.IsType,1,nil,TYPE_TRAP)) and (gB:IsExists(Card.IsType,1,nil,TYPE_TRAP)) then
		local tc=gB:GetFirst()
		local sp=nil
		while tc do
			if tc:IsType(TYPE_TRAP) and sp==nil then
				sp=tc
				gBFinal:Merge(gA)
				gA:Clear()
				gA:AddCard(tc)
				tc=gB:GetNext()
				if not tc then tc=gDeck:RandomSelect(tp,1) end
				gA:AddCard(tc)
			else
				gBFinal:AddCard(tc)
			end
			tc=gB:GetNext()
		end
	end
	if gA:GetCount()+gB:GetCount()<count then
		local add=count-gA:GetCount()-gB:GetCount()
		local gtmp=gDeck:RandomSelect(tp,add)
		gB:Merge(gtmp)
	end
	count=count-gA:GetCount()
	aux.SpeedDuelSendToHandWithExile(tp,gA)
	local fc=gB:GetFirst()
	while count>0 and fc do
		aux.SpeedDuelSendToHandWithExile(tp,fc)
		fc=gB:GetNext()
		count=count-1
	end
	e:Reset()
end