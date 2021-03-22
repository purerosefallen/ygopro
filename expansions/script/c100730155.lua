--高速决斗技能-暴怒的雷霆
Duel.LoadScript("speed_duel_common.lua")
function c100730155.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730155.operation,c100730155.con,aux.Stringid(100730155,0))
	local e1=Effect.GlobalEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100730155.operation)
	c:RegisterEffect(e1)
	aux.SpeedDuelBeforeDraw(c,c100730155.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730155.Isgod(c)
	return c:IsOriginalCodeRule(10000020) and c:IsFaceup()
end

function c100730155.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local ht=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ht>=4 then return end
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730155.Isgod,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsPlayerCanDraw(tp,4-ht)
end
function c100730155.operation(e,tp,eg,ep,ev,re,r,rp)
	local ht=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ht<4 then
		Duel.Hint(HINT_CARD,1-tp,100730155)
		Duel.Draw(tp,4-ht,REASON_RULE)
	end
end

function c100730155.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c100730155.tgfilter)
	e2:SetValue(LOCATION_HAND)
	Duel.RegisterEffect(e2,tp)
	e:Reset()
end

function c100730155.tgfilter(e,c)
	return c:IsOriginalCodeRule(10000020)
end