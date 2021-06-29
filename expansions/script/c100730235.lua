--高速决斗技能-幸运石
Duel.LoadScript("speed_duel_common.lua")
function c100730235.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730235.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730235.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730235)
	local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK,0,0,3,nil,31461282)
	if g:GetCount()>0 then
		Duel.SSet(tp,g)
	end
	e:Reset()
end
