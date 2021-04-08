--高速决斗技能-活死人的呼声
Duel.LoadScript("speed_duel_common.lua")
function c100730279.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730279.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730279.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730279)
	local c=Duel.CreateToken(tp,97077563)
	Duel.SSet(tp,c)
	e:Reset()
end