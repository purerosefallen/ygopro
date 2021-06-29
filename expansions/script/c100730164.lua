--高速决斗技能-它是索加！
Duel.LoadScript("speed_duel_common.lua")
function c100730164.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730164.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730164.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730164)local g2=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_DECK,0,1,1,nil,0xbc)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEDOWN_ATTACK)
	end
	e:Reset()
end