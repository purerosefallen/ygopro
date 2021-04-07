--高速决斗技能-法老的陵墓
Duel.LoadScript("speed_duel_common.lua")
function c100730077.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730077.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730077.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730077)
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,31076103)
	if g1:GetCount()==0 then return end
	local tc=g1:GetFirst()
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	g=g:RandomSelect(tp,1)
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	local c=Duel.CreateToken(tp,4081094)
	aux.SpeedDuelSendToHandWithExile(tp,c)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK,0,1,1,nil,47355498)
	if g2:GetCount()>0 then
		Duel.SSet(tp,g2)
	end
	e:Reset()
end
