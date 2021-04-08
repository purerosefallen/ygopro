--高速决斗技能-我的怪兽卡
Duel.LoadScript("speed_duel_common.lua")
function c100730036.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(66865880,c)
	aux.SpeedDuelBeforeDraw(c,c100730036.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730036.monfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsLevelBelow(4)
end
function c100730036.filter(c,g)
	if not c100730036.monfilter(c) then return false end
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
function c100730036.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730036.filter,tp,LOCATION_DECK,0,6,nil,g) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730036,0))
		e:Reset()
		return
	end
	Duel.Hint(HINT_CARD,1-tp,100730036)
	g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	local count=aux.SpeedDuelSendToDeckWithExile(tp,g)
	local gA=Group.CreateGroup()
	local gB=Group.CreateGroup()
	local gDeck=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_DECK,0,nil)
	gA=gDeck:RandomSelect(tp,2)
	gDeck:Sub(gA)
	gB=gDeck:RandomSelect(tp,5)
	gDeck:Sub(gB)
	local gBFinal=Group.CreateGroup()
	if (not gA:IsExists(c100730036.monfilter,1,nil)) and (gB:IsExists(c100730036.monfilter,1,nil)) then
		local tc=gB:GetFirst()
		local sp=nil
		while tc do
			if c100730036.monfilter(tc) and sp==nil then
				sp=tc
				gBFinal:Merge(gA)
				gA:Clear()
				gA:AddCard(tc)
				tc=gB:GetNext()
				if not tc then
					tc=gDeck:RandomSelect(tp,1):GetFirst()
					break
				end
				gA:AddCard(tc)
			else
				gBFinal:AddCard(tc)
			end
			tc=gB:GetNext()
		end
	end
	if gA:GetCount()+gBFinal:GetCount()<count then
		local add=count-gA:GetCount()-gBFinal:GetCount()
		local gtmp=gDeck:RandomSelect(tp,add)
		gBFinal:Merge(gtmp)
	end
	local fc=gA:GetFirst()
	while count>0 and fc do
		aux.SpeedDuelSendToHandWithExile(tp,fc)
		fc=gA:GetNext()
		count=count-1
	end
	fc=gBFinal:GetFirst()
	while count>0 and fc do
		aux.SpeedDuelSendToHandWithExile(tp,fc)
		fc=gBFinal:GetNext()
		count=count-1
	end
	e:Reset()
end