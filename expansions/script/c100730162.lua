--高速决斗技能-恐龙基因
Duel.LoadScript("speed_duel_common.lua")
function c100730162.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730162.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730162.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730162)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	Duel.RegisterEffect(e1,tp)
	Duel.Recover(tp,350,REASON_EFFECT)
end