--高速决斗技能-给我笑灿烂些！
Duel.LoadScript("speed_duel_common.lua")
function c100730160.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730160.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730160.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCode(EVENT_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCountLimit(1)
	e1:SetOperation(c100730160.recop)
	Duel.RegisterEffect(e1,1-tp)
end

function c100730160.recop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=1-tp or Duel.GetLP(tp)<1000 then return end
	Duel.Hint(HINT_CARD,1-tp,100730160)
	Duel.Damage(tp,50,REASON_RULE)
end