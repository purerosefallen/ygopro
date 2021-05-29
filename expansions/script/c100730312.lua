--高速决斗技能-纹章展开
Duel.LoadScript("speed_duel_common.lua")
function c100730312.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730312.skill,c100730312.con,aux.Stringid(100730312,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730312.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
end
function c100730312.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730312)
	local d=Duel.TossDice(tp,1) 
	local count=Duel.GetTurnCount()
	if d>=count then return end
	local c=Duel.CreateToken(tp,15744417)
	Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	e:Reset()
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,43061293)
	if g1:GetCount()==0 then return end
	Duel.SendtoHand(g1,tp,REASON_RULE)
end