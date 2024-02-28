--高速决斗技能-我早就见过那玩意了
Duel.LoadScript("speed_duel_common.lua")
function c100730221.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730221.skill,c100730221.con,aux.Stringid(100730221,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730221.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil)
end
function c100730221.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,1,nil)
	local c=g:GetFirst()
	if c then
	   Duel.Hint(HINT_CARD,1-tp,100730221)
	   local code=c:GetCode()
	   local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_GRAVE,nil,code)
	   if g:GetCount()>=1 then
			Duel.Recover(tp,g:GetCount()*500,REASON_RULE)
	   elseif g:GetCount()==0 then
			Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730221,1))
		end
	end
end