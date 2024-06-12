--高速决斗技能-友情的力量
Duel.LoadScript("speed_duel_common.lua")
function c100730164.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730164.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730164.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REVERSE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c100730164.rev)
	Duel.RegisterEffect(e1,tp)
end

function c100730164.rev(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)~=0
end