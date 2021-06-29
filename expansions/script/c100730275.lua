--高速决斗技能-京塔 海滨地区
Duel.LoadScript("speed_duel_common.lua")
function c100730275.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730275.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730275.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,76806714)
	if g1:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,1-tp,100730275)
	Duel.SSet(tp,g1)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,0,1,nil,56111151)
	local tc=g2:GetFirst()
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	g=g:RandomSelect(tp,1)
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	local c=Duel.CreateToken(tp,15820147)
	aux.SpeedDuelSendToHandWithExile(tp,c)
	e:Reset()
end