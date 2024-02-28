--高速决斗技能-佐克现身
Duel.LoadScript("speed_duel_common.lua")
function c100730255.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730255.skill,c100730255.con,aux.Stringid(100730255,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730255.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
end
function c100730255.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730255)
	local d=Duel.TossDice(tp,1) 
	local count=Duel.GetTurnCount()
	if d>=count then return end
	local c=Duel.CreateToken(tp,97642679)
	Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,3,nil,4614116)
	if g1:GetCount()==0 then return end
	Duel.SendtoHand(g1,tp,REASON_RULE)
	e:Reset()
end