--高速决斗技能-空手组合技100
Duel.LoadScript("speed_duel_common.lua")
function c100730130.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(33904024,c)
	aux.SpeedDuelMoveCardToFieldCommon(77859858,c)
	aux.SpeedDuelMoveCardToFieldCommon(40555959,c)
	aux.SpeedDuelMoveCardToFieldCommon(80921533,c)
	aux.SpeedDuelBeforeDraw(c,c100730130.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730130.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730130)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	aux.SpeedDuelSendToDeckWithExile(tp,g)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_EXTRA,0,1,1,nil,95453143)
	if g2:GetCount()>0 then
		local tc=g2:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP_ATTACK)	 
		local c=Duel.CreateToken(tp,81020646)
		Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP_ATTACK)
		local d=Duel.CreateToken(tp,13582837)
		Duel.Summon(tp,d,false,nil)
	end
	e:Reset()
end