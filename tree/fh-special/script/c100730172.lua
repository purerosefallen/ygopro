--高速决斗技能-准备战斗！
Duel.LoadScript("speed_duel_common.lua")
function c100730172.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730172.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730172.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c100730172.lpop)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730172.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730172)
	Duel.Recover(tp,200,REASON_EFFECT)
end