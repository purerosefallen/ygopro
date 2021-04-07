--高速决斗技能-通往暗黑深处
Duel.LoadScript("speed_duel_common.lua")
function c100730260.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730260.skill,c100730260.con,aux.Stringid(100730260,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730260.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730260.filter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsPlayerCanDraw(tp,1)
end
function c100730260.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local g1=Duel.GetMatchingGroup(c100730260.filter,tp,LOCATION_HAND,0,1,nil)
	Duel.Hint(HINT_CARD,1-tp,100730260)
	local c=g1:Select(tp,1,1,nil)
	Duel.SendtoGrave(c,nil,1,REASON_RULE)
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730260.efilter,tp,LOCATION_GRAVE,0,4,nil,g) then
		Duel.Draw(tp,1,REASON_RULE)
		return
	end
	local op=Duel.SelectOption(tp,aux.Stringid(100730260,1),aux.Stringid(100730260,2))
	if op==0 then
		Duel.Draw(tp,1,REASON_RULE)
	elseif op==1 then
		local g2=Duel.SelectMatchingCard(tp,Card.IsType,tp,LOCATION_DECK,0,1,1,nil,TYPE_MONSTER)
		if g2:GetCount()==0 then
			Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730260,0))
		else Duel.SendtoHand(g2,tp,REASON_RULE)
		end
	end
end
function c100730260.filter(c)
	return c:IsType(TYPE_NORMAL) and c:IsRace(RACE_FIEND) and c:IsType(TYPE_MONSTER)
end
function c100730260.efilter(c,g)
	if not c:IsRace(RACE_FIEND) then return false end
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